//
//  DwordleAction.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

enum DwordleAction: Equatable {
    case addLetter(Character)
    case evaluate
    case backspace
    case newGame
    case cancelTapped
}
