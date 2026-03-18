//
//  HomePage.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import SwiftUI

struct HomePage: View {

    var body: some View {
        NavigationStack {
            VStack {

                Spacer()

                Text("WORD GUESS")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Spacer()

                NavigationLink(destination: DifficultyPage()) {
                    Text("New Game")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()

                HStack {

                    NavigationLink(destination: LeaderboardPage()) {
                        Text("Leaderboard")
                            .padding()
                    }

                    Spacer()

                    NavigationLink(destination: ProfilePage()) {
                        Text("Profile")
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
}
#Preview {
    HomePage()
}
