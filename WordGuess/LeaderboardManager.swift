//
//  LeaderboardManager.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import Foundation
internal import Combine

class LeaderboardManager: ObservableObject {

    @Published var scores: [PlayerScore] = []

    let playerName = "You"

    init() {
        // Always use the seeded leaderboard
        generateLeaderboard()
    }

    // Seed data of players
    func generateLeaderboard() {

        scores = [
            PlayerScore(name: "Alex", score: 5000),
            PlayerScore(name: "Jordan", score: 4918),
            PlayerScore(name: "Taylor", score: 4837),
            PlayerScore(name: "Morgan", score: 4755),
            PlayerScore(name: "Casey", score: 4673),
            PlayerScore(name: "Riley", score: 4592),
            PlayerScore(name: "Jamie", score: 4510),
            PlayerScore(name: "Avery", score: 4429),
            PlayerScore(name: "Quinn", score: 4347),
            PlayerScore(name: "Cameron", score: 4265),
            PlayerScore(name: "Drew", score: 4184),
            PlayerScore(name: "Parker", score: 4102),
            PlayerScore(name: "Hayden", score: 4020),
            PlayerScore(name: "Reese", score: 3939),
            PlayerScore(name: "Dakota", score: 3857),
            PlayerScore(name: "Skyler", score: 3776),
            PlayerScore(name: "Rowan", score: 3694),
            PlayerScore(name: "Emerson", score: 3612),
            PlayerScore(name: "Finley", score: 3531),
            PlayerScore(name: "Sawyer", score: 3449),
            PlayerScore(name: "Charlie", score: 3367),
            PlayerScore(name: "River", score: 3286),
            PlayerScore(name: "Phoenix", score: 3204),
            PlayerScore(name: "Blake", score: 3122),
            PlayerScore(name: "Elliot", score: 3041),
            PlayerScore(name: "Logan", score: 2959),
            PlayerScore(name: "Peyton", score: 2878),
            PlayerScore(name: "Marley", score: 2796),
            PlayerScore(name: "Spencer", score: 2714),
            PlayerScore(name: "Bailey", score: 2633),
            PlayerScore(name: "Micah", score: 2551),
            PlayerScore(name: "Shiloh", score: 2469),
            PlayerScore(name: "Kendall", score: 2388),
            PlayerScore(name: "Rory", score: 2306),
            PlayerScore(name: "Sloane", score: 2224),
            PlayerScore(name: "Tatum", score: 2143),
            PlayerScore(name: "Lennon", score: 2061),
            PlayerScore(name: "Ellis", score: 1980),
            PlayerScore(name: "Jules", score: 1898),
            PlayerScore(name: "Ari", score: 1816),
            PlayerScore(name: "Remy", score: 1735),
            PlayerScore(name: "Frankie", score: 1653),
            PlayerScore(name: "Justice", score: 1571),
            PlayerScore(name: "Zion", score: 1490),
            PlayerScore(name: "Oakley", score: 1408),
            PlayerScore(name: "Greer", score: 1327),
            PlayerScore(name: "Indigo", score: 1245),
            PlayerScore(name: "Onyx", score: 1163),
            PlayerScore(name: "Sage", score: 1082),
            PlayerScore(name: "Noel", score: 1000)
        ]
        // Ensure sorted descending just in case
        scores.sort { $0.score > $1.score }
        save()
    }

    // Add or update user score
    func addScore(name: String, score: Int) {

        if let index = scores.firstIndex(where: { $0.name == playerName }) {
            let current = scores[index]
            let updated = PlayerScore(name: current.name, score: current.score + score)
            scores[index] = updated
        } else {
            scores.append(PlayerScore(name: name, score: score))
        }

        // Sort descending
        scores.sort { $0.score > $1.score }

        // Keep only top 100
        if scores.count > 100 {
            scores = Array(scores.prefix(100))
        }

        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encoded, forKey: "leaderboard")
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "leaderboard"),
           let decoded = try? JSONDecoder().decode([PlayerScore].self, from: data) {

            scores = decoded
        }
    }
}

