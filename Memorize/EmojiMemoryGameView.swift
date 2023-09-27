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
   private let dealAnimation: Animation = .easeInOut(duration: 1)
   private let dealInterval: TimeInterval = 0.15
   private let deckWidth: CGFloat = 50

   var body: some View {
      VStack {
         cards
            .foregroundStyle(viewModel.color)
         HStack {
            score
            Spacer()
            deck.foregroundColor(viewModel.color)
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
         if isDealt(card) == true {
            CardView(card)
               .matchedGeometryEffect(id: card.id, in: dealingNamespace)
               .transition(.asymmetric(insertion: .identity, removal: .identity))
//               .transition(.identity)
               .padding(spacing)
               .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
               .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
               .onTapGesture {
                  choose(card)
               }

         }
      }
   }

   @State private var dealt = Set<Card.ID>()

   private
   func isDealt(_ card: Card) -> Bool {
      dealt.contains(card.id)
   }

   private
   var undealtCards: [Card] {
      viewModel.cards.filter { !isDealt($0) }
   }

   @Namespace private
   var dealingNamespace

   private
   var deck: some View {
      ZStack {
         ForEach(undealtCards) { card in
            CardView(card)
               .matchedGeometryEffect(id: card.id, in: dealingNamespace)
               .transition(.asymmetric(insertion: .identity, removal: .identity))
         }
      }
      .frame(width: deckWidth, height: deckWidth / aspectRatio)
      .onTapGesture {
         deal()
      }
   }

   private func
   deal() {
      var delay: TimeInterval = 0
      for card in viewModel.cards {
         withAnimation(dealAnimation.delay(delay)) {
            _ = dealt.insert(card.id)
         }
         delay += dealInterval
      }
   }

   private func
   choose(_ card: Card) {
      withAnimation {
         let scoreBeforeChossing = viewModel.score
         viewModel.choose(card)
         let scoreChange = viewModel.score - scoreBeforeChossing
         lastScoreChange = (scoreChange, causedByCardId: card.id)
      }
   }

   @State private var lastScoreChange = (0, causedByCardId: "")

   private func
   scoreChange(causedBy card: Card) -> Int {
      let (amount, causedByCardId: id) = lastScoreChange
      return card.id == id ? amount : 0
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
