import SwiftUI

struct LeaderboardPage: View {

    @EnvironmentObject var leaderboard: LeaderboardManager
    @EnvironmentObject var profile: ProfileManager

    @State private var showFull = false

    var body: some View {

        VStack {

            Text("Leaderboard")
                .font(.largeTitle)
                .padding()
                // Keep leaderboard in sync with profile score
                .onAppear { syncUserScoreToProfile() }
                .onChange(of: profile.totalScore) { _ in
                    syncUserScoreToProfile()
                }

            // User Status
            if let status = userStatus() {
                HStack(spacing: 12) {
                    Text("Your Rank: \(status.rank)")
                        .font(.headline)
                    Text("•")
                        .foregroundStyle(.secondary)
                    Text("Points: \(status.points)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 4)
            }

            // Toggle Button
            Button(showFull ? "Show Less" : "Show Full Leaderboard ") {
                withAnimation {
                    showFull.toggle()
                }
            }
            .padding(.bottom)

            // Header
            HStack {
                Text("Rank")
                    .frame(width: 40, alignment: .leading)

                Text("Name")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Points")
                    .frame(width: 80, alignment: .trailing)
            }
            .font(.headline)
            .padding(.horizontal)

            List {

                ForEach(displayedPlayers(), id: \.element.id) { index, player in

                    HStack {

                        Text("\(index + 1)")
                            .frame(width: 40, alignment: .leading)

                        Text(player.name)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(player.score)")
                            .frame(width: 80, alignment: .trailing)
                    }
                    .padding(.vertical, 4)
                    .background(player.name == leaderboard.playerName ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                }
            }
        }
    }

    // MARK: - Core Logic

    func displayedPlayers() -> [(offset: Int, element: PlayerScore)] {

        let all = Array(leaderboard.scores.enumerated())

        guard let userIndex = leaderboard.scores.firstIndex(where: { $0.name == leaderboard.playerName }) else {
            return Array(all.prefix(5))
        }

        if showFull {
            return all
        }

        let start = max(userIndex - 2, 0)
        let end = min(userIndex + 2, leaderboard.scores.count - 1)

        return Array(all[start...end])
    }

    // Computes the user's current rank (1-based) and points
    private func userStatus() -> (rank: Int, points: Int)? {
        guard let index = leaderboard.scores.firstIndex(where: { $0.name == leaderboard.playerName }) else {
            return nil
        }
        let rank = index + 1
        let points = leaderboard.scores[index].score
        return (rank, points)
    }

    // Sync the leaderboard's user score to match the profile's total score
    private func syncUserScoreToProfile() {
        let name = leaderboard.playerName
        let desired = profile.totalScore
        // Find current leaderboard score for the user (0 if absent)
        let current = leaderboard.scores.first(where: { $0.name == name })?.score ?? 0
        let delta = desired - current
        if delta != 0 {
            // Reuse addScore to adjust by the delta (positive or negative)
            leaderboard.addScore(name: name, score: delta)
        }
    }
}

