//
//  ProfileManager.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-04-12.
//

import Foundation
internal import Combine

class ProfileManager: ObservableObject {
    
    @Published var wordsGuessed = 0
    @Published var gamesPlayed = 0
    @Published var totalScore = 0
    @Published var totalTime = 0

    init() {
        load()
    }

    func updateAfterGame(won: Bool, score: Int, time: Int) {

        gamesPlayed += 1
        totalTime += time

        if won {
            wordsGuessed += 1
            totalScore += score
        }

        save()
    }

    func save() {

        let data: [String: Int] = [
            "wordsGuessed": wordsGuessed,
            "gamesPlayed": gamesPlayed,
            "totalScore": totalScore,
            "totalTime": totalTime
        ]

        UserDefaults.standard.set(data, forKey: "profileStats")
    }

    func load() {

        if let data = UserDefaults.standard.dictionary(forKey: "profileStats") as? [String: Int] {

            wordsGuessed = data["wordsGuessed"] ?? 0
            gamesPlayed = data["gamesPlayed"] ?? 0
            totalScore = data["totalScore"] ?? 0
            totalTime = data["totalTime"] ?? 0
        }
    }
}
