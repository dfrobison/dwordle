//
//  dwordleApp.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import SwiftUI
import ComposableArchitecture

@main
struct dwordleApp: App {
    var body: some Scene {
        WindowGroup {
            DwordleView(
                store: Store(initialState: DwordleState(columns: 5, rows: 6),
                             reducer: dwordleReducer,
                             environment: DwordleEnvironment(wordProvider: WordProvider(), mainRunLoop: .main))
            )
        }
    }
}
