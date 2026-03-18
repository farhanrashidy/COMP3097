//
//  WordDictionary.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import Foundation

struct WordDictionary {

    static let easy = [
        "APPLE","GRAPE","BREAD","CHAIR","PLANT"
    ]

    static let medium = [
        "BRICK","PLANE","SHEEP","SHARE","STONE"
    ]

    static let hard = [
        "QUACK","ZEBRA","KNACK","FJORD","LYMPH"
    ]

    static func randomWord(difficulty: String) -> String {
        
        switch difficulty {
        case "Easy":
            return easy.randomElement()!
        case "Medium":
            return medium.randomElement()!
        default:
            return hard.randomElement()!
        }
    }
}
