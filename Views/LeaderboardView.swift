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
    
    var body: some View {
        
        let colori = [Color("Color"),Color("Color1")]
        
        NavigationView{
            
            ZStack{

            VStack{
                VStack {
                    Button {
                        withAnimation { self.backToMainScreen()}
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
                            
                        }.offset(x: 10, y:35)
                    }
                    
                Text("Leaderboard")
                        .font(Font.custom("Daydream", size: 12))
                        .scaleEffect(y:2.0)
                    
                    .foregroundStyle(Color(red: 220 / 255, green: 150 / 255, blue: 255 / 255))
                    .shadow(color:.black,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(50)
                    .offset(y:-10)
                    
                } 
                Image("leaderboard")
                    .scaleEffect(CGSize(width: 1.15, height: 1))
                    .frame(width: 160,height: 250)
                    .offset(y:-35)
                    
                }
            }
            .frame(width: 420, height: 900, alignment: .center)
            
            .background(LinearGradient(gradient: Gradient(colors: colori), startPoint: .bottom, endPoint: .top))
            .background(Image("backgroundStartScreen")).scaleEffect(CGSize(width: 2.0, height: 2.0))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea()
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
    
}
#Preview {
    LeaderboardView(currentGameState: .constant(GameState.leaderboard))
        .previewLayout(.fixed(width: 420, height: 950))
}
