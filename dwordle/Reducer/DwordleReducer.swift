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
        case .newGame:
            state.newGame(wordOfTheDay: environment.wordProvider.generateWord().uppercased())
            return .none
        case .cancelTapped:
            state.alert = nil
            return .none
        case .onAppear:
            return Effect.concatenate(.fireAndForget {
                environment.wordProvider.load()
            },
            Effect(value: .newGame))
    }
}
