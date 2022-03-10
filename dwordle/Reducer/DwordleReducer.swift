//
//  DwordleReducer.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import ComposableArchitecture

let dwordleReducer = Reducer<DwordleState, DwordleAction, DwordleEnvironment> { state, action, environment in
    struct TimerId: Hashable {}
    
    switch action {
        case let .addLetter(letter):
            let startTimer = state.startTimer
            state.addLetter(letter)
            return startTimer ? .none : Effect(value: .startTimer)
            
        case .nextRow:
            state.nextRow()
            return .none
            
        case .validateWord:
            state.validateWord(isValidWord: environment.wordProvider.isWord)
            return .none
            
        case .evaluate:
            state.evaluate()
            return state.canPlay ? .none : .cancel(id: TimerId())
            
        case .backspace:
            state.backspace()
            return .none
            
        case .newGame:
            state.newGame(environment.wordProvider.generateWord)
            return .cancel(id: TimerId())
            
        case .cancelTapped:
            state.alert = nil
            return .none
            
        case .onAppear:
            return Effect(value: .newGame)
            
        case .timerUpdate:
            state.duration += 1
            return .none
            
        case .startTimer:
            return Effect.timer(id: TimerId(), every: 1, tolerance: .zero, on: environment.mainRunLoop)
                .map { _ in .timerUpdate }
    }
}
