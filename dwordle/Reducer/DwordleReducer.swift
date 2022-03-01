//
//  DwordleReducer.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import ComposableArchitecture

let dwordleReducer = Reducer<DwordleState, DwordleAction, DwordleEnvironment> { state, action, environment in
    
    switch action {
        case let .addLetter(letter):
            state.addLetter(letter)
            return .none
        case .evaluate:
            state.evaluate()
            return .none
        case .backspace:
            state.backspace()
            return .none
    }
}
