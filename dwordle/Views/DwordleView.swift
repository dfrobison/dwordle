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
                viewStore.send(.newGame)
            }
            .padding(8)
            HStack {
                Button("Enter") {
                    viewStore.send(.evaluate)
                }
                
                Button("A") {
                    viewStore.send(.addLetter("A"))
                }
                
                Button("B") {
                    
                }
                Button("C") {
                    
                }
                Button("D") {
                    
                }
                Button("BS") {
                    viewStore.send(.backspace)
                }
            }
        }
        .padding(24)
        .background(Color(UIColor.red))
    }
}

struct DwordleView_Previews: PreviewProvider {
    static var previews: some View {
        DwordleView( store: Store(initialState: DwordleState(columns: 5, rows: 6),
                                  reducer: dwordleReducer,
                                  environment: DwordleEnvironment()))
    }
}

