//
//  User.swift
//  RoachVentures
//
//  Created by Beniamino Gentile on 18/12/23.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID = UUID()
    var userName: String = "Ghostroach"
    var userScore: Int = 0
    
    init(userName: String, userScore: Int) {
        self.userName = userName
        self.userScore = userScore
    }
    
    static var emptyUser: User {
        User(userName: "", userScore: 0)
    }
}

extension User {
    static let sampleData: [User] = [
        User(userName: "Herobrine", userScore: 25),
        User(userName: "DTT", userScore: 50),
        User(userName: "Santo", userScore: 100)
    ]
}
