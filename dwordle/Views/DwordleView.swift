//
//  DwordleView.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import SwiftUI
import ComposableArchitecture




struct DwordleView: View {
    let store: Store<DwordleState, DwordleAction>
    @ObservedObject var viewStore: ViewStore<DwordleState, DwordleAction>
    
    init(store: Store<DwordleState, DwordleAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        VStack {
            DwordleGridView(
                width: viewStore.columns,
                height: viewStore.rows,
                spacing: 8
            ) { row, column in
                DwordleCellView(cell: viewStore.dwordleGrid[row][column])
            }
            .frame(maxHeight: .infinity)
            Button("New Game") {
                withAnimation {
                    viewStore.send(.newGame)
                }
            }
            .padding(8)
            DwordleKeyboardView() {
                viewStore.send(.addLetter($0))
            } sendEvaluate: {
                viewStore.send(.evaluate)
            } sendDelete: {
                viewStore.send(.backspace)
            }
        }
        .padding(24)
        .background(Color(.systemGray6))
    }
}

struct DwordleView_Previews: PreviewProvider {
    static var previews: some View {
        DwordleView( store: Store(initialState: DwordleState(columns: 5, rows: 6),
                                  reducer: dwordleReducer,
                                  environment: DwordleEnvironment()))
    }
}

