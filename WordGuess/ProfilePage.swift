//
//  ProfilePage.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import SwiftUI

struct ProfilePage: View {

    @EnvironmentObject var profile: ProfileManager

    var body: some View {

        List {

            HStack {
                Text("Words Guessed")
                Spacer()
                Text("\(profile.wordsGuessed)")
            }

            HStack {
                Text("Games Played")
                Spacer()
                Text("\(profile.gamesPlayed)")
            }

            HStack {
                Text("Total Score")
                Spacer()
                Text("\(profile.totalScore)")
            }

            HStack {
                Text("Time Played")
                Spacer()
                Text("\(profile.totalTime)s")
            }
        }
        .navigationTitle("Profile")
    }
}
