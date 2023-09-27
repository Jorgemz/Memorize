//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
   typealias Card = MemoryGame<String>.Card

   @ObservedObject
   var viewModel: EmojiMemoryGame

   private let aspectRatio: CGFloat = 2/3
   private let spacing: CGFloat = 4

   var body: some View {
      VStack {
         cards
            .foregroundStyle(viewModel.color)
         HStack {
            score
            Spacer()
            shuffle
         }
         .font(.largeTitle)
      }
      .padding()
  }

   private var score: some View {
      Text("Score: \(viewModel.score)")
         .animation(nil)
   }

   private var shuffle: some View {
      Button("Shuffle") { withAnimation { viewModel.shuffle() } }
   }

   private var 
   cards: some View {
      AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
         CardView(card)
            .padding(spacing)
            .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
            .onTapGesture {
               withAnimation {
                  viewModel.choose(card)
               }
            }
      }
   }

   private func
   scoreChange(causedBy card: Card) -> Int {
      0
   }

}


#Preview {
   EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

import os.log
extension Logger {
   static let system = Bundle.main.bundleIdentifier!
   static let log = Logger(subsystem: system, category: "Log")
}

typealias os = Logger
