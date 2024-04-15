//
//  gameover.swift
//  Roachventures
//
//  Created by Alessandra Amorico on 12/12/23.
//

import SwiftUI



struct GameOver: View {
    
    // The game state is used to transition between the different states of the game
        @Binding var currentGameState: GameState
        @StateObject var gameLogic: GameLogic =  GameLogic.shared
        
        @Environment(\.scenePhase) private var scenePhase
        @Binding var users: [User]
        let saveAction: ()->Void
        
        @State private var newUser = User.emptyUser
        
        var body: some View {
            
            let colori = [Color("Color"),Color("Color1")]
            NavigationView{
                
                ZStack{

                    VStack {
                        Spacer()
                        
                    
                    Text("GAME OVER")
                            .font(Font.custom("Daydream", size: 12))
                            .scaleEffect(y:2.0)
                        
                        .foregroundStyle(Color(red: 220 / 255, green: 150 / 255, blue: 255 / 255))
                        .shadow(color:.black,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(10)
                    
                    
                        TextField("Player Name", text: $newUser.userName)
                            .font(Font.custom("Daydream", size: 14))
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .background(RoundedRectangle(cornerRadius: 10).fill(.purple).opacity(0.5))
                            .padding()
                            .fixedSize()

                    Spacer()
                        
                        
                        Spacer()
                        
                        VStack{
                            GameScoreView(time: $gameLogic.sessionDuration, gameLogic: GameLogic.shared)

                            Spacer()
                            GameHighscoreView(time: $gameLogic.sessionDuration, users: .constant(User.sampleData), saveAction: {})
                            
                        }
                        
                        
                        Spacer()
                        
                        Button {
                            newUser.userScore = gameLogic.totalScore
                            users.append(newUser)
                            users = users.sorted {$0.userScore > $1.userScore}
                            withAnimation { self.backToMainScreen() }
                        } label: {
                            HStack {
                                Text("Title Screen")
                                    .font(Font.custom("Daydream", size: 14))
                                    .foregroundStyle(.white)
                                    .shadow(color:.purple,radius: 10)
                                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    
                                
                            }
                        }
        

                   
                        
                        
                    }
                    .frame(width: 420, height: 60)
                        
                        
                        
                    
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
            .onChange(of: scenePhase) {
                if scenePhase == .inactive { saveAction()}
            }
        }
        
        private func backToMainScreen() {
            self.currentGameState = .mainScreen
        }
        
        private func restartGame() {
            self.currentGameState = .playing
        }
        
    //    private func finishGame() {
    //            // Aggiorna l'highscore se il punteggio attuale è superiore
    //            let currentScore = Int(self.gameLogic.sessionDuration)
    //            if currentScore > UserDefaults.standard.integer(forKey: "highscore") {
    //                UserDefaults.standard.setValue(currentScore, forKey: "highscore")
    //                highscore = currentScore
    //            }
    //
    //            self.gameLogic.finishTheGame()
    //        }

    }



    #Preview {
        GameOver(currentGameState: .constant(GameState.playing), users: .constant(User.sampleData), saveAction: {})
            .previewLayout(.fixed(width: 420, height: 950))

    }
