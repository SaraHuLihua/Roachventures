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
    
    @Environment(\.scenePhase) private var scenePhase
        @Binding var users: [User]
        
        let saveAction: ()->Void
    var body: some View {
        
        switch currentGameState {
        case .mainScreen:
            MainScreenView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .playing:
            GameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .leaderboard:
            LeaderboardView(currentGameState: $currentGameState, users: $users, saveAction: {})
                .environmentObject(gameLogic)
                .onChange(of: scenePhase) {
                                    if scenePhase == .inactive { saveAction() }
                                }
            
        case .gameOver:
            GameOver(currentGameState: $currentGameState, users: $users, saveAction: {})
                .environmentObject(gameLogic)
        case .story:
            StoryView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
            
        case .credits:
            CreditsView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }

}

#Preview {
    ContentView(users: .constant(User.sampleData), saveAction: {})
}
