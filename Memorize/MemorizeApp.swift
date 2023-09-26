//
//  MemorizeApp.swift
//  Memorize
//
//  Created by JG on 25/09/23.
//

import SwiftUI

@main
struct MemorizeApp: App {

   @StateObject var game = EmojiMemoryGame()
   
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
