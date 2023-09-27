//
//  MemorizeGame.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {

   private(set) var cards: Array<Card>
   private(set) var score = 0

   init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
      cards = []
      // add numberOfPairsOfCards x 2 cards
      for pairIndex in 0..<max(2, numberOfPairsOfCards) {
         let content = cardContentFactory(pairIndex)
         cards.append(Card(content: content, id: "\(pairIndex+1)a"))
         cards.append(Card(content: content, id: "\(pairIndex+1)b"))
      }
   }

   private var indexOfTheOneOnlyFaceCard: Int? {
      get { cards.indices.filter { index in cards[index].isFaceUp }.only }
      set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
   }

   mutating func choose(_ card: Card) {
      if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
         if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched {

            if let potencialMatchIndex = indexOfTheOneOnlyFaceCard {
               if cards[choosenIndex].content == cards[potencialMatchIndex].content {
                  cards[choosenIndex].isMatched = true
                  cards[potencialMatchIndex].isMatched = true
                  score += 2 + cards[choosenIndex].bonus + cards[potencialMatchIndex].bonus
               } else {
                  if cards[choosenIndex].hasBeenSeen {
                     score -= 1
                  }
                  if cards[potencialMatchIndex].hasBeenSeen {
                     score -= 1
                  }
               }
            } else {
               indexOfTheOneOnlyFaceCard = choosenIndex
            }

            cards[choosenIndex].isFaceUp = true
         }
      }
   }

   mutating func shuffle() {
      cards.shuffle()
      print(cards)
   }

   struct Card: Equatable, Identifiable, CustomDebugStringConvertible {

      var isFaceUp = false {
         didSet {
            if isFaceUp == true {
               startUsingBonusTime()
            } else {
               stopUsingBonusTime()
            }
            if oldValue == true && !isFaceUp {
               hasBeenSeen = true
            }
         }
      }
      var hasBeenSeen = false
      var isMatched = false {
         didSet {
            if isMatched {
               stopUsingBonusTime()
            }
         }
      }
      let content: CardContent

      // MARK: - Bonus Time

      // call this when the card transitions to face up state
      private mutating 
      func
      startUsingBonusTime() {
         if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
            lastFaceUpDate = Date()
         }
      }

      // call this the card goes back face down or gets matched
      private mutating 
      func
      stopUsingBonusTime() {
         pastFaceUpTime = faceUpTime
         lastFaceUpDate = nil
      }

      // the bonus earned so far (one point for every second of bonusTimeLimit that was not uased)
      // this gets smaller and smaller the longer the card remains face up without being matched
      var bonus: Int {
         Int(bonusTimeLimit * bonusPercentRemaining)
      }

      // percentage of the bonus time remaining
      var bonusPercentRemaining: Double {
         bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
      }

      // how long this card has ever been face up and unmatched during its lifetime
      // basically, pastFaceUpTime + time since lastFaceUpDate
      var faceUpTime: TimeInterval {
         if let lastFaceUpDate {
            pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
         } else {
            pastFaceUpTime
         }
      }

      // can be zero wich would mean 'no bonus available" for matching this card quickly
      var bonusTimeLimit: TimeInterval = 6

      // the last time this card was turned face up
      var lastFaceUpDate: Date?

      // the accumulated time this card was face up in the past
      // (i.e. not including the current time it's been face up if it is currently so)
      var pastFaceUpTime: TimeInterval = 0

      let id: String

      var debugDescription: String {
         "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
      }
   }
}

extension Array {
   var only: Element? {
      return count == 1 ? first : nil
   }
}
