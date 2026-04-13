//
//  TileView.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import SwiftUI

struct TileView: View {

    var letter: String
    var color: TileColor

    var body: some View {

        ZStack {

            Rectangle()
                .fill(backgroundColor())

            Text(letter)
                .font(.title)
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 60)
        .border(Color.gray)
    }

    func backgroundColor() -> Color {

        switch color {
        case .correct:
            return .green
        case .present:
            return .yellow
        case .absent:
            return .gray
        case .empty:
            return Color.gray.opacity(0.2)
        }
    }
}
