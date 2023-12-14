//
//  ContentView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # ContentView
 *
 *   This view is responsible for managing the states of the game, presenting the proper view.
 **/

struct ContentView: View {
    
    // The navigation of the app is based on the state of the game.
    // Each state presents a different view on the SwiftUI app structure
    @State var currentGameState: GameState = .mainScreen
    
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: GameLogic = GameLogic()
    
    var body: some View {
        
        switch currentGameState {
        case .mainScreen:
            MainScreenView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .playing:
            GameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .leaderboard:
            LeaderboardView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .gameOver:
            GameOver(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }
}

#Preview {
    ContentView()
}
