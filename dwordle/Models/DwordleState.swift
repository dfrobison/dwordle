//
//  DwordleState.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import ComposableArchitecture

struct DwordleState: Equatable {
    let columns: Int
    let rows: Int
    var row = 0
    var column = 0
    var wordOfTheDay = "WORDS"
    var words: Set<String> = []
    var dwordleGrid: [[DwordleCell]] = [[]]
    var lost = false
    var solved = false
    
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
                if character == wordOfTheDay[wordOfTheDay.index(wordOfTheDay.startIndex, offsetBy: cellIndex)] {
                    dwordleGrid[row][cellIndex].evalation = .exact
                } else if wordOfTheDay.contains(character) {
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
        } else if row == rows - 1 {
            lost = true
        }
    }
    
    mutating func newGame() {
        row = 0
        column = 0
        lost = false
        solved = false
        self.dwordleGrid = Array(
            repeating: .init(repeating: .init(), count: columns),
            count: rows
        )
    }
}
