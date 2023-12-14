//
//  GameScoreView.swift
//  Roachventures
//
//  Created by Beniamino Gentile on 12/12/23.
//

import SwiftUI

/**
 * # GameScoreView
 * Custom UI to present how many points the player has scored.
 *
 * Customize it to match the visual identity of your game.
 */

struct GameScoreView: View {
    @Binding var time: TimeInterval
    
    var body: some View {
        
        HStack{
            Text("Score:")
                .font(Font.custom("Daydream", size: 14))
                .foregroundStyle(.brown)
            Text("\(Int(time))")
                .font(Font.custom("Daydream", size: 14))
                .foregroundStyle(.white)
                .shadow(color:.purple,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }    }
}

#Preview {
    GameScoreView(time: .constant(100))
        .previewLayout(.fixed(width: 300, height: 100))
}
