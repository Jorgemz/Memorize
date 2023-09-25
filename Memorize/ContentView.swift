//
//  ContentView.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import SwiftUI

struct ContentView: View {

   let emojis: Array<String> = ["👻", "🎃", "🕷️", "👿", "😈"]

   var body: some View {
      HStack {
         ForEach(emojis.indices, id: \.self) { index in
            CardView(content: emojis[index], isFaceUp: false)
         }
      }
      .foregroundStyle(.orange).padding()
  }
}

struct CardView: View {

   let content: String
   @State var isFaceUp = false

   var body: some View {
      ZStack {
         let base = RoundedRectangle(cornerRadius: 12)
         if isFaceUp {
            base.fill(.white)
            base.strokeBorder(lineWidth: 2)
            Text(content).font(.largeTitle)
         } else {
            base.fill()
         }
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
