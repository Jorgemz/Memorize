//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

   private static let emojis = ["👻", "🎃", "🕷️", "👿", "💀", "❄️", "🧙🏻", "🙀", "👹", "😱", "☠️", "🍭"]
   private static func createMemoryGame() -> MemoryGame<String> {
      MemoryGame<String>( numberOfPairsOfCards: 16) { pairIndex in
         if emojis.indices.contains(pairIndex) {
            emojis[pairIndex]
         } else {
            "⁉️"
         }
      }
   }

   @Published
   private var model = createMemoryGame()

   var cards: Array<MemoryGame<String>.Card> {
      model.cards
   }

   // MARK: - Intents

   func shuffle() {
      model.shuffle()
   }

   func choose(_ card: MemoryGame<String>.Card) {
      model.choose(card: card)
   }

}
