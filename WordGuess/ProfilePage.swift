//
//  ProfilePage.swift
//  WordGuess
//
//  Created by Sheikh Rashidy on 2026-03-17.
//

import SwiftUI

struct ProfileStat: Identifiable {

    let id = UUID()
    let title: String
    let value: String
}

struct ProfilePage: View {

    let stats = [
        ProfileStat(title: "Words Guessed", value: "25"),
        ProfileStat(title: "Time Played", value: "2h 30m"),
        ProfileStat(title: "Total Score", value: "350"),
        ProfileStat(title: "Games Won", value: "12")
    ]

    var body: some View {

        VStack {

            Text("Profile")
                .font(.largeTitle)

            List(stats) { stat in
                HStack {
                    Text(stat.title)
                    Spacer()
                    Text(stat.value)
                }
            }
        }
    }
}
#Preview {
    ProfilePage()
}
