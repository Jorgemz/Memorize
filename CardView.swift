//
//  CardView.swift
//  Memorize
//
//  Created by JG on 26/09/23.
//

import SwiftUI

struct CardView: View {
   
   typealias Card = MemoryGame<String>.Card

   let card: Card

   init(_ card: Card) {
      self.card = card
   }

   var body: some View {
      Pie(endAngle: .degrees(240))
         .opacity(Constants.Pie.opacity)
         .overlay {
            Text(card.content)
               .font(.system(size: Constants.FontSize.largest))
               .minimumScaleFactor(Constants.FontSize.scaleFactor)
               .multilineTextAlignment(.center)
               .aspectRatio(1, contentMode: .fit)
               .padding(Constants.Pie.inset)
         }
         .padding(Constants.inset)
         .cardify(isFaceUp: card.isFaceUp)
         .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
   }

   private struct Constants {
      
      static let inset: CGFloat = 5

      struct FontSize {
         static let largest: CGFloat = 200
         static let smallest: CGFloat = 10
         static let scaleFactor: CGFloat =  smallest / largest
      }

      struct Pie {
         static let opacity: CGFloat = 0.5
         static let inset: CGFloat = 5
      }

   }
}

#Preview {
   VStack {
      HStack {
         CardView(CardView.Card(isFaceUp: true, content: "X", id: "test1"))
            .aspectRatio(4/3, contentMode: .fit)
         CardView(CardView.Card(content: "X", id: "test1"))
      }
      HStack {
         CardView(CardView.Card(isFaceUp: true, content: "This is very long and string I hope it fits", id: "test1"))
         CardView(CardView.Card(isMatched: true, content: "X", id: "test1"))
      }
   }
   .padding()
   .foregroundStyle(.green)
}