//
//  GameScoreView.swift
//  Roachventures
//
//  Created by sara hu lihua on 12/12/23.
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
    @ObservedObject var gameLogic: GameLogic
    @State private var isNewHighscore: Bool = false

    var body: some View {
        VStack {
            // Score or Highscore based on the condition
            HStack {
                Text(isNewHighscore  ? "Record:" : "Score:")
                    .font(Font.custom("Daydream", size: 14))
                    .foregroundStyle(isNewHighscore ? .yellow : .brown)
                    .shadow(color: isNewHighscore  ? .yellow : .clear, radius: 5)
                Text("\(gameLogic.totalScore)")
                    .font(Font.custom("Daydream", size: 14))
                    .foregroundStyle(.white)
                    .shadow(color: isNewHighscore  ? .white : .purple, radius: 5)
            }
        
        }
        .onAppear {
            // Check if the current score is a new highscore
            isNewHighscore = gameLogic.totalScore > UserDefaults.standard.integer(forKey: "highscore")
        }
        .onChange(of: gameLogic.totalScore) { newTotalScore in
            // Update the high score status when the totalScore changes
            isNewHighscore = newTotalScore > UserDefaults.standard.integer(forKey: "highscore")
        }
        .onDisappear {
            // Update the high score and save it only at the end of the game
            if isNewHighscore {
                UserDefaults.standard.setValue(gameLogic.totalScore, forKey: "highscore")
            }
        }
    }
}

#Preview {
    GameScoreView(time: .constant(100), gameLogic: GameLogic.shared)
        .previewLayout(.fixed(width: 300, height: 100))
}

//struct GameScoreView: View {
//    @Binding var time: TimeInterval
//    @ObservedObject var gameLogic: GameLogic
//    @Binding var highScores: [Int]
//
//
//
//    var body: some View {
//        VStack {
//            // Score
//            HStack {
//                Text(gameLogic.totalScore > highScores.first ?? 0 ? "Highscore:" : "Score:")
//                    .font(Font.custom("Daydream", size: 14))
//                    .foregroundStyle(.brown)
//
//                Text("\(gameLogic.totalScore)")
//                    .font(Font.custom("Daydream", size: 14))
//                    .foregroundStyle(.white)
//                    .shadow(color: .purple, radius: 10)
//            }
//
//        }
//
//    }
//}
//
//
//#Preview {
//    GameScoreView(time: .constant(100), gameLogic: GameLogic.shared, highScores: .constant([100, 90, 80]))
//        .previewLayout(.fixed(width: 300, height: 100))
//}


