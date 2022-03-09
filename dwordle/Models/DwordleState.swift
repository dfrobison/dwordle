//
//  DwordleState.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import ComposableArchitecture

struct DwordleState: Equatable {
    typealias KeyEvaluation = [Character : CellEvaluation]
    
    var alert: AlertState<DwordleAction>?
    let columns: Int
    let rows: Int
    var row = 0
    var column = 0
    var guessWord = ""
    var keys: KeyEvaluation = [:]
    var dwordleGrid: [[DwordleCell]] = [[]]
    var lost = false
    var solved = false
    var isValidatedWord = false
    var canPlay: Bool { lost == false && solved == false }
    
    private func getWord() -> String {
        String(dwordleGrid[row].compactMap({ cell in cell.letter }))
    }
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        newGame()
    }
    
    mutating func addLetter(_ letter: Character) {
        guard row < rows && column < columns else { return }
        dwordleGrid[row][column].letter = letter
        column += 1
    }
    
    mutating func validateWord(isValidWord: (String) -> Bool) {
        isValidatedWord = false
        
        guard column == columns else {
            alertNeedMoreCharacters()
            return
        }
        
        guard isValidWord(getWord()) else {
            alertEnterValidWord()
            return
        }
        
        isValidatedWord = true
    }
    
    mutating func evaluate() {
        guard row < rows && isValidatedWord else { return }
        
        for cellIndex in 0..<columns {
            if let character = dwordleGrid[row][cellIndex].letter {
                if character == guessWord[guessWord.index(guessWord.startIndex, offsetBy: cellIndex)] {
                    dwordleGrid[row][cellIndex].evalation = .exact
                    keys[character] = .exact
                } else if guessWord.contains(character) {
                    dwordleGrid[row][cellIndex].evalation = .included
                    
                    switch keys[character] {
                    case .none, .some(.miss):
                        keys[character] = .included
                    default:
                        break
                    }
                } else {
                    dwordleGrid[row][cellIndex].evalation = .miss
                    
                    if case .none = keys[character] {
                        keys[character] = .miss
                    }
                }
            }
        }
        
        checkWinOrLose(dwordleGrid[row].map { $0.evalation ?? .miss })
    }
    
    mutating func nextRow() {
        guard row < rows && isValidatedWord else { return }
        
        row += 1
        column = 0
        isValidatedWord = false
    }
    
    mutating func alertNeedMoreCharacters() {
        alert = .init( title: TextState("Please enter \(columns - column) more charaters"),
                       dismissButton: .default(TextState("OK"), action: .send(.cancelTapped)))
    }
    
    mutating func alertEnterValidWord() {
        alert = .init( title: TextState("Please enter a valid word"),
                       dismissButton: .default(TextState("OK"), action: .send(.cancelTapped)))
    }

    mutating func backspace() {
        guard row < rows && column > 0 else { return }
        
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
