import SwiftUI

struct GamePage: View {

    let difficulty: String
    
    @EnvironmentObject var leaderboard: LeaderboardManager
    
    @State private var targetWord = ""
    
    @State private var guesses: [[String]] =
        Array(repeating: Array(repeating: "", count: 5), count: 6)
    
    @State private var colors: [[TileColor]] =
        Array(repeating: Array(repeating: .empty, count: 5), count: 6)

    @State private var currentRow = 0
    @State private var guess = ""
    
    @State private var startTime = Date()
    @State private var timeElapsed = 0
    
    @State private var timer: Timer?
    
    @State private var message = ""
    
    var body: some View {

        VStack(spacing: 20) {

            Text("Difficulty: \(difficulty)")
            
            Text("Time: \(timeElapsed)s")

            grid

            TextField("Enter word", text: $guess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.characters)
                .onChange(of: guess) { _, newValue in
                    guess = String(newValue.prefix(5))
                }

            Button("Submit") {
                submitGuess()
            }

            Text(message)
                .font(.headline)

        }
        .onAppear {

            targetWord = WordDictionary.randomWord(difficulty: difficulty)
            
            startTimer()
        }
        .padding()
    }

    var grid: some View {

        VStack(spacing: 5) {

            ForEach(0..<6, id: \.self) { row in

                HStack(spacing: 5) {

                    ForEach(0..<5, id: \.self) { col in

                        TileView(
                            letter: guesses[row][col],
                            color: colors[row][col]
                        )
                    }
                }
            }
        }
    }

    func submitGuess() {

        guard guess.count == 5 else { return }

        let guessWord = guess.uppercased()
        let target = Array(targetWord)

        for i in 0..<5 {

            let letter = String(guessWord[guessWord.index(guessWord.startIndex, offsetBy: i)])

            guesses[currentRow][i] = letter

            if letter == String(target[i]) {
                colors[currentRow][i] = .correct
            }
            else if targetWord.contains(letter) {
                colors[currentRow][i] = .present
            }
            else {
                colors[currentRow][i] = .absent
            }
        }

        if guessWord == targetWord {
            winGame()
            return
        }

        currentRow += 1
        guess = ""

        if currentRow == 6 {
            loseGame()
        }
    }

    func startTimer() {

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeElapsed += 1
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    func calculateScore() -> Int {

        let difficultyMultiplier = difficulty == "Easy" ? 1 :
                                   difficulty == "Medium" ? 2 : 3

        let rowBonus = (6 - currentRow) * 50

        let timePenalty = timeElapsed * 2

        return max((rowBonus * difficultyMultiplier) - timePenalty, 0)
    }

    func winGame() {

        stopTimer()

        let score = calculateScore()

        leaderboard.addScore(name: "Player", score: score)

        message = "You won! Score: \(score)"
    }

    func loseGame() {

        stopTimer()

        message = "The word was \(targetWord)"
    }
}
#Preview{
    GamePage(difficulty: "Easy")
}
