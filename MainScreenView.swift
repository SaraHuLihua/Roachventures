//
//  ContentView.swift
//  Roachventures
//
//  Created by Gianrocco Di Tomaso on 10/12/23.
//

import SwiftUI

/**
 * # MainScreenView
 **/

struct MainScreenView: View {
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    
    // Change it on the Constants.swift file
    var gameTitle: String = MainScreenProperties.gameTitle
    
    // Change it on the Constants.swift file
    var gameInstructions: [Instruction] = MainScreenProperties.gameInstructions
    
    // Change it on the Constants.swift file
    let accentColor: Color = MainScreenProperties.accentColor
    
    var body: some View {
        
        let colori = [Color("Color"),Color("Color1")]
        NavigationView{
            
            ZStack{

                VStack {
                    Spacer()
                    
                
                Text("ROACHVENTURES")
                        .font(Font.custom("Daydream", size: 12))
                        .scaleEffect(y:2.0)
                    
                    .foregroundStyle(Color(red: 220 / 255, green: 150 / 255, blue: 255 / 255))
                    .shadow(color:.black,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(50)
                Spacer()
                    
                    VStack(spacing: 10){
                        Button {
                            withAnimation { self.startGame() }
                        } label: {
                            Text("Play")
                                .font(Font.custom("Daydream", size: 14))
                                .foregroundStyle(.white)
                                .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        Button {
                            withAnimation { self.showLeaderboard() }
                        } label: {
                            Text("Leaderboard")
                                .font(Font.custom("Daydream", size: 10))
                                .foregroundStyle(Color(red: 220 / 255, green: 150 / 255, blue: 255 / 255))                   .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        
                        Button {
                            withAnimation { self.showStory() }
                        } label: {
                            Text("Story")
                                .font(Font.custom("Daydream", size: 10))
                                .foregroundStyle(.white)
                                .shadow(color: .purple, radius: 10)
                        }
                    }
                    
                    Spacer()

                Image("roachScreen")
                        .scaleEffect(x: 1.6, y:1.6)
                    .shadow(radius: 16)
                    
                    
                    Spacer()
                    
                    
                    
                }
                .frame(width: 420, height: 500)
                    
                    
                    
                
            }
            .frame(width: 420, height: 900, alignment: .center)
            
            .background(LinearGradient(gradient: Gradient(colors: colori), startPoint: .bottom, endPoint: .top))
            .background(Image("backgroundStartScreen")).scaleEffect(CGSize(width: 2.0, height: 2.0))
            
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    /**
     * Function responsible to start the game.
     * It changes the current game state to present the view which houses the game scene.
     */
    private func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
    
    private func showLeaderboard() {
        print("- Starting the game...")
        self.currentGameState = .leaderboard
    }
    
    private func showStory() {
        print("- Showing the story...")
        SKTAudio.sharedInstance().stopBGMusic()
        self.currentGameState = .story
    }
}
#Preview {
    MainScreenView(currentGameState: .constant(GameState.mainScreen))
}
