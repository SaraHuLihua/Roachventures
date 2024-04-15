//
//  RoachventuresApp.swift
//  Roachventures
//
//  Created by sara hu lihua on 10/12/23.
//

import SwiftUI

@main
struct RoachventuresApp: App {
    @AppStorage("usedcount") var usedcount = false
    @StateObject private var store = UserStore()
    var body: some Scene {
        WindowGroup {
            if !usedcount {
                StoryView(currentGameState: .constant(GameState.story))
            } else {
                ContentView(users: $store.users) {
                    Task {
                        do {
                            try await store.save(users: store.users)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
    }
}
