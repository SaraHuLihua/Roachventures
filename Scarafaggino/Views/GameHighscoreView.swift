//
//  GameHighscoreView.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 15/12/23.
//
import SwiftUI

struct GameHighscoreView: View {
    
    @Binding var time: TimeInterval
    @State private var highScores: [Int] = [] // Change the data type to Int
    
    @Binding var users: [User]
        
        @Environment(\.scenePhase) private var scenePhase
        let saveAction: ()->Void
    
    var body: some View {
        HStack {
            Text("Highscore:")
                .font(Font.custom("Daydream", size: 14))
                .foregroundStyle(.brown)
            Text("\(highScores.first ?? 0)") // Display totalScore instead of time
                .font(Font.custom("Daydream", size: 14))
                .foregroundStyle(.white)
                .shadow(color: .purple, radius: 10)
        }
        .onAppear {
            // Load all previously saved high scores (if any)
            if let savedHighScores = UserDefaults.standard.array(forKey: "highScores") as? [Int] {
                highScores = savedHighScores
            } else {
                highScores = []
            }
        }
        .onChange(of: time) { newTime in
            // Update the high score only at the end of the game
        }
        .onDisappear {
            // Update the high score and save the list only at the end of the game
            highScores.append(GameLogic.shared.totalScore) // Use totalScore instead of time
            highScores.sort(by: >) // Sort in descending order
            highScores = Array(highScores.prefix(5)) // Take the top 5
            UserDefaults.standard.setValue(highScores, forKey: "highScores")
        }
    }
}


//
//struct GameHighscoreView: View {
//
//    @Binding var time: TimeInterval
//    @State private var highScores: [TimeInterval] = []
//
//    var body: some View {
//        HStack {
//            Text("Highscore:")
//                .font(Font.custom("Daydream", size: 14))
//                .foregroundStyle(.brown)
//            Text("\(Int(highScores.first ?? 0))")
//                .font(Font.custom("Daydream", size: 14))
//                .foregroundStyle(.white)
//                .shadow(color: .purple, radius: 10)
//        }
//        .onAppear {
//            // Carica tutti gli highscore salvati precedentemente (se presenti)
//            if let savedHighScores = UserDefaults.standard.array(forKey: "highScores") as? [TimeInterval] {
//                highScores = savedHighScores
//            } else {
//                highScores = []
//            }
//        }
//        .onChange(of: time) { newTime in
//            // Aggiorna l'highscore solo alla fine del gioco
//        }
//        .onDisappear {
//            // Aggiorna l'highscore e salva la lista solo alla fine del gioco
//            highScores.append(time)
//            highScores.sort(by: >) // Ordina in modo decrescente
//            highScores = Array(highScores.prefix(5)) // Prendi i primi 5
//            UserDefaults.standard.setValue(highScores, forKey: "highScores")
//        }
//    }
//}
//
//
//#Preview {
//    GameHighscoreView(time: .constant(100))
//        .previewLayout(.fixed(width: 300, height: 100))
//}
