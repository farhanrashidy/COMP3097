//
//  LeaderboardManager.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

internal import Combine
import Foundation

class LeaderboardManager: ObservableObject {

    @Published var scores: [PlayerScore] = []

    init() {
        load()
    }

    func addScore(name: String, score: Int) {

        let newScore = PlayerScore(name: name, score: score)
        scores.append(newScore)

        scores.sort { $0.score > $1.score }

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
