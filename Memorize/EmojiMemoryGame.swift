//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

   typealias Card = MemoryGame<String>.Card


   private static let emojis = ["👻", "🎃", "🕷️", "👿", "💀", "❄️", "🧙🏻", "🙀", "👹", "😱", "☠️", "🍭"]
   private static func createMemoryGame() -> MemoryGame<String> {
      MemoryGame<String>( numberOfPairsOfCards: 2) { pairIndex in
         if emojis.indices.contains(pairIndex) {
            emojis[pairIndex]
         } else {
            "⁉️"
         }
      }
   }

   @Published
   private var model = createMemoryGame()

   var cards: Array<Card> {
      model.cards
   }

   var color: Color {
      .orange
   }

   // MARK: - Intents

   func shuffle() {
      model.shuffle()
   }

   func choose(_ card: Card) {
      model.choose(card)
   }

}
