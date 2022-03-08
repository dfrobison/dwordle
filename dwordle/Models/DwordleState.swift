//
//  DwordleState.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import ComposableArchitecture

struct DwordleState: Equatable {
    var alert: AlertState<DwordleAction>?
    let columns: Int
    let rows: Int
    var row = 0
    var column = 0
    var guessWord = ""
    var dwordleGrid: [[DwordleCell]] = [[]]
    var lost = false
    var solved = false
    
    var canPlay: Bool {
        lost == false && solved == false
    }
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        newGame()
    }
    
    mutating func addLetter(_ letter: Character) {
        if column < columns {
            dwordleGrid[row][column].letter = letter
            column += 1
        }
    }
    
    mutating func evaluate() {
        guard row < rows else { return }
        
        for cellIndex in 0..<columns {
            if let character = dwordleGrid[row][cellIndex].letter {
                if character == guessWord[guessWord.index(guessWord.startIndex, offsetBy: cellIndex)] {
                    dwordleGrid[row][cellIndex].evalation = .exact
                } else if guessWord.contains(character) {
                    dwordleGrid[row][cellIndex].evalation = .included
                } else {
                    dwordleGrid[row][cellIndex].evalation = .miss
                }
            } else {
                dwordleGrid[row][cellIndex].evalation = .miss
            }
        }
        
        checkWinOrLose(dwordleGrid[row].map { $0.evalation ?? .miss })
        row += 1
        column = 0
    }
    
    mutating func backspace() {
        guard column > 0 else { return }
        
        column -= 1
        dwordleGrid[row][column].letter = nil
    }
    
    mutating func checkWinOrLose(_ rowEvaluation: [CellEvaluation]) {
        if rowEvaluation.solved {
            solved = true
            alert = .init(
                title: TextState("You Won! 🎉🎉🎉🎉"),
                dismissButton: .default(TextState("OK"), action: .send(.cancelTapped))
              )
        } else if row == rows - 1 {
            lost = true
            alert = .init(
                title: TextState("You Lost!"),
                message: TextState("The word was:\n\(guessWord)"),
                dismissButton: .default(TextState("OK"), action: .send(.cancelTapped))
              )
        }
    }
    
    mutating func newGame(_ guessWord: String = "") {
        row = 0
        column = 0
        lost = false
        solved = false
        self.guessWord = guessWord
        self.dwordleGrid = Array(
            repeating: .init(repeating: .init(), count: columns),
            count: rows
        )
    }
}
