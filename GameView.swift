//
//  GameView.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 14/12/23.
//


import SwiftUI
import SpriteKit
import GameplayKit

/**
 * # ArcadeGameView
 *   This view is responsible for presenting the game and the game UI.
 *  In here you can add and customize:
 *  - UI elements
 *  - Different effects for transitions in and out of the game scene
 **/

struct GameView: View {
    
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    @StateObject var gameLogic: GameLogic =  GameLogic.shared
    
    @State private var isPaused = false
    
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /**
     * # The Game Scene
     *   If you need to do any configurations on your game scene, like changing it's size
     *   for example, do it here.
     **/
    var arcadeGameScene: GameScene {
        let scene = GameScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // View that presents the game scene
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .statusBar(hidden: true)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea()
            
            GameScoreView(time: $gameLogic.sessionDuration, gameLogic: GameLogic.shared)
                .position(CGPoint(x: 80, y: 70.0))
            
            
            // Pause Button
                        Button {
                            // Toggle the pause state
                            isPaused.toggle()
                        } label: {
                            Text(isPaused ? "Resume" : "Pause")
                                .font(Font.custom("Daydream", size: 14))
                                .foregroundColor(.white)
                                .shadow(color: .purple, radius: 10)
                        }
                        .position(CGPoint(x: 345, y: 70.0))
                        .alert(isPresented: $isPaused) {
                            Alert(
                                title: Text("Game Paused"),
                                message: Text("Do you want to resume?"),
                                primaryButton: .default(Text("Resume")) {
                                    // Resume the game
                                    isPaused.toggle()
                                },
                                secondaryButton: .cancel(Text("Quit")) {
                                    // Handle any quit or main screen presentation here
                                    presentMainScreen()
                                }
                            )
                        }

            
//            GameHighscoreView()
//
//
//            if score > default.value(forKey: "highscore") as! Int {
//                defaults.setValue(score, forKey: "highScore")
//            }
            
        }
        .onChange(of: gameLogic.isGameOver) { _ in
            if gameLogic.isGameOver {
                
                /** # PRO TIP!
                 * You can experiment by adding other types of animations here before presenting the game over screen.
                 */
                
                withAnimation {
                    self.presentGameOverScreen()
                }
            }
        }
        .onAppear {
            gameLogic.restartGame()
            //BackGround Music
            SKTAudio.sharedInstance().playBGMusic("AcquaESale.mp3")
            
        }
    }
    
    /**
     * ### Function responsible for presenting the main screen
     * At the moment it is not being used, but it could be used in a Pause menu for example.
     */
    private func presentMainScreen() {
        self.currentGameState = .mainScreen
    }
//
//    private func presentStory() {
//        self.currentGameState = .story
//    }
//
    /**
     * ### Function responsible for presenting the game over screen.
     * It changes the current game state to present the GameOverView.
     */
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
}

#Preview {
    GameView(currentGameState: .constant(GameState.playing))
}
