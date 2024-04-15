//
//  UserStore.swift
//  RoachVentures
//
//  Created by Beniamino Gentile on 18/12/23.
//

import Foundation
import SwiftUI

@MainActor
class UserStore: ObservableObject {
    @Published var users: [User] = []
    
    private static func fileURL() throws -> URL {
        
        try FileManager.default.url(for: .documentDirectory,
                                    
                                    in: .userDomainMask,
                                    
                                    appropriateFor: nil,
                                    
                                    create: false)
        
        .appendingPathComponent("users.data")
        
    }
    
    func load() async throws {
        
        let task = Task<[User], Error> {
            
            let fileURL = try Self.fileURL()
            
            guard let data = try? Data(contentsOf: fileURL) else {
                
                return []
                
            }
            
            let leaderboardList = try JSONDecoder().decode([User].self, from: data)
            
            return leaderboardList
            
        }
        
        let users = try await task.value
        
        self.users = users
        
    }
    
    func save(users: [User]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(users)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
