//
//  GameView.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 14/12/23.
//


import SwiftUI
import SpriteKit
import GameplayKit




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
    @State private var isTextVisible = true
    
    @State private var isAnimating = false
    @State private var rightImageOpacity = 1.0
    @State private var leftImageOpacity = 1.0
    
    
    
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
            
            VStack {
                HStack(spacing: 150) {
                    Image("touchcontrolRight")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(CGSize(width: 2.0, height: 2.0))
                        .opacity(isAnimating ? 1.0 : rightImageOpacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(Animation.easeInOut(duration: 1.0)) {
                                    rightImageOpacity = 0.0
                                }
                            }
                        }
                    
                    Image("touchcontrolLeft")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(CGSize(width: 2.0, height: 2.0))
                        .opacity(leftImageOpacity)
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                                withAnimation(Animation.easeInOut(duration: 1.5)) {
                                    leftImageOpacity = 0.0
                                }
                            }
                        }
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                
                if isTextVisible {
                    Text("Touch left and right side of the screen to move")
                        .font(Font.custom("Daydream", size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .onAppear {
                            withAnimation(
                                Animation.easeInOut(duration: 2.0)
                                    .delay(2.0) // Add a 2-second delay
                            ) {
                                isTextVisible = false
                            }
                        }
                }}
            .position(x: screenWidth / 2, y: screenHeight / 1.3)
            
            ZStack (alignment: .center){
                GameScoreView(time: $gameLogic.sessionDuration, gameLogic: GameLogic.shared)
                    .position(CGPoint(x: 190, y: 70.0))
            }
            
            
            // Pause Button
            
            
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
