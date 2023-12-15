//
//  GameHighScoreView.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 15/12/23.
//


import SwiftUI

/**
 * # GameScoreView
 * Custom UI to present how many points the player has scored.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameHighscoreView: View {
    @Binding var time: TimeInterval
    
    var body: some View {
        
        HStack{
            Text("Highscore:")
                .font(Font.custom("Daydream", size: 14))
                .foregroundStyle(.brown)
            Text("\(Int(time))")
                .font(Font.custom("Daydream", size: 14))
                .foregroundStyle(.white)
                .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}



#Preview {
    GameHighscoreView(time: .constant(100))
        .previewLayout(.fixed(width: 300, height: 100))
}
