//
//  ContentView.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import SwiftUI

struct ContentView: View {

   let emojis = ["👻", "🎃", "🕷️", "👿", "💀", "❄️", "🧙🏻", "🙀", "👹", "😱", "☠️", "🍭"]
   @State var cardCount = 4

   var body: some View {
      VStack{
         ScrollView {
            cards
         }
         Spacer()
         cardCountAdjusters
      }
      .padding()
  }

   var cards: some View {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 120 ))]) {
         ForEach(0..<cardCount, id: \.self) { index in
            CardView(content: emojis[index])
               .aspectRatio(2/3, contentMode: .fit)
         }
      }
      .foregroundStyle(.orange)
   }

   var cardCountAdjusters: some View {
      HStack {
         cardRemover
         .labelsHidden()
         Spacer()
         cardAdder
      }
      .imageScale(.large)
      .font(.largeTitle)
   }

   func cardCounAdjuster(by offset: Int, symbol: String) -> some View {
      Button("", systemImage: symbol) {
            cardCount += offset
      }
      .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
   }

   var cardRemover: some View {
      cardCounAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
   }

   var cardAdder: some View {
      cardCounAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
   }
}

struct CardView: View {

   let content: String
   @State var isFaceUp = true

   var body: some View {
      ZStack {
         let base = RoundedRectangle(cornerRadius: 12)
         Group {
            base.fill(.white)
            base.strokeBorder(lineWidth: 2)
            Text(content).font(.largeTitle)
         }
         .opacity(isFaceUp ? 1 : 0)
         base.fill().opacity(isFaceUp ? 0 : 1)
      }
      .onTapGesture {
         isFaceUp.toggle()
      }
   }
}

#Preview {
    ContentView()
}

import os.log
extension Logger {
   static let system = Bundle.main.bundleIdentifier!
   static let log = Logger(subsystem: system, category: "Log")
}

typealias os = Logger
