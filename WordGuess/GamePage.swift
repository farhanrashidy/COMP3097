import SwiftUI

struct GamePage: View {
    
    let difficulty: String
    
    @EnvironmentObject var leaderboard: LeaderboardManager
    
    @EnvironmentObject var profile: ProfileManager
    
    // track if game ended
    @State private var isGameOver = false
    
    //keyboard key colors
    @State private var keyColors: [String: TileColor] = [:]
    
    @State private var targetWord = ""
    
    // all guesses
    @State private var guesses: [[String]] =
        Array(repeating: Array(repeating: "", count: 5), count: 6)
    
    // tile color for each guessed letter
    @State private var colors: [[TileColor]] =
        Array(repeating: Array(repeating: .empty, count: 5), count: 6)

    @State private var currentRow = 0
    
    // current type word
    @State private var guess = ""
    
    // timer tracking variables
    @State private var startTime = Date()
    @State private var timeElapsed = 0
    @State private var timer: Timer?
    
    // message to user
    @State private var message = ""
    
    var body: some View {

        VStack(spacing: 20) {

            Text("Difficulty: \(difficulty)")
            
            Text("Time: \(timeElapsed)s")

            grid

            KeyboardView(
                onKeyTap: handleKeyPress,
                keyColors: keyColors
            )

            Text(message)
                .font(.headline)
            
            if isGameOver {

                HStack(spacing: 20) {

                    // Back to Home
                    NavigationLink(destination: HomePage()) {
                        Text("Back to Home")
                            .frame(width: 140, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // Next Level (restart game)
                    Button("Next Level") {
                        resetGame()
                    }
                    .frame(width: 140, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.top)
            }

        }
        .onAppear {

            targetWord = WordDictionary.randomWord(difficulty: difficulty)
            
            startTimer()
        }
        .padding()
    }

    //Game Grid UI
    var grid: some View {

        VStack(spacing: 5) {

            ForEach(0..<6, id: \.self) { row in

                HStack(spacing: 5) {

                    ForEach(0..<5, id: \.self) { col in

                        TileView(
                            letter: displayLetter(row: row, col: col),
                            color: colors[row][col],
                        )
                    }
                }
            }
        }
    }

    
    func resetGame() {

        // Ensure any existing timer is stopped before starting a new one
        stopTimer()

        targetWord = WordDictionary.randomWord(difficulty: difficulty)

        guesses = Array(repeating: Array(repeating: "", count: 5), count: 6)

        colors = Array(repeating: Array(repeating: .empty, count: 5), count: 6)

        // Clear keyboard coloring so keys return to default state
        keyColors.removeAll()

        currentRow = 0
        guess = ""
        message = ""
        timeElapsed = 0
        startTime = Date()
        isGameOver = false

        startTimer()
    }
    
    // display letters on grid
    func displayLetter(row: Int, col: Int) -> String {

        // Show currently typed word in active row
        if row == currentRow && col < guess.count {
            let index = guess.index(guess.startIndex, offsetBy: col)
            return String(guess[index])
        }

        // Show submitted guesses
        return guesses[row][col]
    }
    
    //keyboard input handler
    func handleKeyPress(_ key:String){
        if key == "ENTER"{
            submitGuess()
        }
        else if key == "⌫" {
            if !guess.isEmpty {
                guess.removeLast()
            }
        }
        else{
            if guess.count < 5 {
                guess.append(key)
            }
        }
    }
    
    
    func submitGuess() {

        guard guess.count == 5 else { return }

        let guessWord = guess.uppercased()
        let target = Array(targetWord)

        // Store current row in a temp variable
        let row = currentRow

        for i in 0..<5 {

            let letter = String(guessWord[guessWord.index(guessWord.startIndex, offsetBy: i)])

            guesses[row][i] = letter

            if letter == String(target[i]) {
                colors[row][i] = .correct
            }
            else if targetWord.contains(letter) {
                colors[row][i] = .present
            }
            else {
                colors[row][i] = .absent
            }
            
            let currentColor: TileColor

            if letter == String(target[i]) {
                currentColor = .correct
            }
            else if targetWord.contains(letter) {
                currentColor = .present
            }
            else {
                currentColor = .absent
            }

            colors[row][i] = currentColor

            updateKeyColor(letter: letter, newColor: currentColor)
        }

        // Check win BEFORE moving row
        if guessWord == targetWord {
            winGame()
            return
        }

        // Move to next row AFTER everything is done
        currentRow += 1
        guess = ""

        if currentRow == 6 {
            loseGame()
        }
    }

    func updateKeyColor(letter: String, newColor: TileColor) {

        let current = keyColors[letter]

        // Priority: correct > present > absent
        if current == .correct {
            return
        }

        if current == .present && newColor == .absent {
            return
        }

        keyColors[letter] = newColor
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

        leaderboard.addScore(name: "You", score: score)

        profile.updateAfterGame(
            won: true,
            score: score,
            time: timeElapsed
        )

        message = "You won! Score: \(score)"
        isGameOver = true
    }

    func loseGame() {

        stopTimer()

        profile.updateAfterGame(
            won: false,
            score: 0,
            time: timeElapsed
        )

        message = "The word was \(targetWord)"
        isGameOver = true
    }
}

