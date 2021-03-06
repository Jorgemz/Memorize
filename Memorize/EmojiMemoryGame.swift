//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ๐คจ on 8/06/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis = ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ป", "๐", "๐", "๐", "๐ด", "๐ฒ", "๐ต", "๐", "๐บ", "๐", "๐", "๐", "๐", "โ๏ธ", "๐ซ", "๐ฌ", "๐ฉ", "๐", "๐ธ", "๐", "๐ถ", "โต๏ธ", "๐ค", "โท", "๐", "๐ช", "๐๐ปโโ๏ธ"]
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 9) { pairIndex in
      EmojiMemoryGame.emojis[pairIndex]
    }
  }
  
  @Published private var model = createMemoryGame()
  
  var cards: Array<Card> {
    model.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(_ card: Card) {
    model.choose(card)
  }
}
