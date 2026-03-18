//
//  WordGuessApp.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import SwiftUI

@main
struct WordGuessApp: App {
    
    @StateObject var leaderboard = LeaderboardManager()
    
    var body: some Scene {
        WindowGroup {
            HomePage()
            .environmentObject(leaderboard)
        }
    }
}
