//
//  KeyboardView.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-04-12.
//

import SwiftUI

struct KeyboardView: View {

    let onKeyTap: (String) -> Void
    let keyColors: [String: TileColor]

    // displaying the keyboard
    let rows = [
        ["Q","W","E","R","T","Y","U","I","O","P"],
        ["A","S","D","F","G","H","J","K","L"],
        ["ENTER","Z","X","C","V","B","N","M","⌫"]
    ]

    var body: some View {

        VStack(spacing: 8) {

            ForEach(rows, id: \.self) { row in

                HStack(spacing: 6) {

                    ForEach(row, id: \.self) { key in

                        Button(action: {
                            onKeyTap(key)
                        }) {

                            Text(key)
                                .frame(minWidth: keyWidth(key), minHeight: 45)
                                .background(backgroundColor(for: key))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }
                }
            }
        }
    }

    func keyWidth(_ key: String) -> CGFloat {
        return key == "ENTER" || key == "⌫" ? 60 : 32
    }

    // keyboard color changes depending on the presence of the letter
    func backgroundColor(for key: String) -> Color {

        guard let color = keyColors[key] else {
            return Color.gray.opacity(0.3)
        }

        switch color {
        case .correct: return .green
        case .present: return .yellow
        case .absent: return .gray
        case .empty: return Color.gray.opacity(0.3)
        }
    }
}
