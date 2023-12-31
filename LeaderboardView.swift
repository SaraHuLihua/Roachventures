//
//  ContentView.swift
//  Roachventures
//
//  Created by Gianrocco Di Tomaso on 10/12/23.
//

import SwiftUI

struct LeaderboardView: View {
    
    // The game state is used to transition between the different states of the game
    @Binding var currentGameState: GameState
    @State private var highScores: [TimeInterval] = []
    
    
    var body: some View {
        
        let colori = [Color("Color"),Color("Color1")]
        
        NavigationView{
            
            ZStack{
                
                VStack{
                    
                    
                    Button {
                        backToMainScreen()
                    } label: {
                        HStack {
                            
                            Text("Back")
                                .font(Font.custom("Daydream", size: 14))
                                .foregroundStyle(.white)
                                .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                            
                            Image("backButton")
                                .scaleEffect(0.6)
                                .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: 0))
                            
                            
                        }
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    
                    Text("Leaderboard")
                        .font(Font.custom("Daydream", size: 12))
                    
                        .scaleEffect(y:2.0)
                    
                        .foregroundStyle(Color(red: 220 / 255, green: 150 / 255, blue: 255 / 255))
                        .shadow(color:.black,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding()
                
                    ZStack {
                        
                        Image("leaderboard")
                            .scaleEffect(CGSize(width: 1.15, height: 1))
                            .frame(width: 160,height: 250)
                        
                        
                        // Add a list of recent scores here
                        List(0..<highScores.count, id: \.self) { index in
                            let position = index + 1
                            let score = Int(highScores[index])
                            
                            HStack {
                                Text("Roach \(position)°:")
                                    .font(Font.custom("Daydream", size: 10))
                                    .foregroundColor(.white)
                                
                                
                                Text("\(score)")
                                    .font(Font.custom("Daydream", size: 10))
                                    .foregroundColor(.white)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 5))
                            }
                            .listRowBackground(Color.clear)
//                            .position(CGPoint(x: 60.0, y: -20.0))
                            .offset(x: 15, y: 20)
                            
                        }
                    }
                    .frame(width: 150, height: 250)
                    .background(Color.white.opacity(0.0))
                    
            
                    .listStyle(PlainListStyle())
                }
            }
            .frame(width: 420, height: 900, alignment: .center)
            
            .background(LinearGradient(gradient: Gradient(colors: colori), startPoint: .bottom, endPoint: .top))
            .background(Image("backgroundStartScreen")).scaleEffect(CGSize(width: 2.0, height: 2.0))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea()
        .onAppear {
            loadHighScores()
        }
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    private func loadHighScores() {
            if let savedHighScores = UserDefaults.standard.array(forKey: "highScores") as? [TimeInterval] {
                highScores = savedHighScores
            } else {
                highScores = [TimeInterval](repeating: 0, count: 5)
            }
        }
    
}
#Preview {
    LeaderboardView(currentGameState: .constant(GameState.leaderboard))
        .previewLayout(.fixed(width: 420, height: 950))
}
