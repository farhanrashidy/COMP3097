import SwiftUI

struct LeaderboardPage: View {

    @EnvironmentObject var leaderboard: LeaderboardManager

    var body: some View {

        VStack {

            Text("Leaderboard")
                .font(.largeTitle)

            List(leaderboard.scores) { player in

                HStack {
                    Text(player.name)
                    Spacer()
                    Text("\(player.score)")
                }
            }
        }
    }
}
