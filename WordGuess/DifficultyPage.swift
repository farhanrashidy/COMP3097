//
//  DifficultyPage.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import SwiftUI

//User will select the difficult they want
struct DifficultyPage: View {

    var body: some View {
        VStack(spacing: 20) {

            Text("Select Difficulty")
                .font(.title)

            NavigationLink(destination: GamePage(difficulty: "Easy")) {
                Text("Easy")
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: GamePage(difficulty: "Medium")) {
                Text("Medium")
                    .frame(width: 200, height: 50)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: GamePage(difficulty: "Hard")) {
                Text("Hard")
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    DifficultyPage()
}
