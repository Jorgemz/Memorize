//
//  MemoryGame.swift
//  Memorize
//
//  Created by 🤨 on 5/06/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable       {
  private(set) var cards: Array<Card>
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int?
  {
    get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
    set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
  }
  
  internal mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
       !cards[chosenIndex].isFaceUp,
       !cards[chosenIndex].isMatched
    {
      if let potencialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potencialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potencialMatchIndex].isMatched = true
        }
        cards[chosenIndex].isFaceUp = true
      } else {
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
    }
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    // add numberOfPairsOfCards * 2 to cards array
    
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content, id: pairIndex*2))
      cards.append(Card(content: content, id: pairIndex*2+1))
    }
    
  }
  
  struct Card: Identifiable {
    var isFaceUp = false
    var isMatched = false
    let content: CardContent
    let id: Int
  }
}

extension Array {
  var oneAndOnly: Element? {
    if count == 1 {
      return first
    } else {
      return nil
    }
  }
}
