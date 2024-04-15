//
//  GameLogic.swift
//  Scarafaggino
//
//  Created by sara hu lihua on 14/12/23.
//

import Foundation

class GameLogic: ObservableObject {
    
    
    var currentScoreAdded: Bool = false
    
    // Single instance of the class
    static let shared: GameLogic = GameLogic()
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        
        // TODO: Customize!
        
        self.currentScore = -10 //così lo score parte da 0, perchè prima partiva già da score = 10 e ad ogni secondo si aggiungevano altri 10
        self.sessionDuration = 0
        self.isGameOver = false
    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Aggiungi una variabile per tenere traccia dei punti delle monete
    var coinPoints: Int = 10
    @Published var totalScore: Int = 0 // Aggiungi questa variabile

    // Increases the score by a certain amount of points
    func score(points: Int) {
        
        // TODO: Customize!
        
        self.currentScore = self.currentScore + points
        self.totalScore = self.currentScore // Aggiungi questa linea
    }
    
    // Aggiorna la funzione createRandomCoin per assegnare i punti delle monete
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
            if !currentScoreAdded {
                self.sessionDuration = self.sessionDuration + Double(self.currentScore)
                currentScoreAdded = true
            }

            self.sessionDuration = self.sessionDuration + timeIncrement
        }
    

    
    
    func restartGame() {
        
        // TODO: Customize!
        self.currentScoreAdded = false
        self.setUpGame()
    }
    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
}
