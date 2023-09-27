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
                  score += 2
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
            if oldValue == true && !isFaceUp {
               hasBeenSeen = true
            }
         }
      }
      var hasBeenSeen = false
      var isMatched = false
      let content: CardContent

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
