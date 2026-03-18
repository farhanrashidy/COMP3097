//
//  Models.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import Foundation

struct PlayerScore: Identifiable, Codable {
    let id = UUID()
    let name: String
    let score: Int
}

enum TileColor {
    case correct
    case present
    case absent
    case empty
}
