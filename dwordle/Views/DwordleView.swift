//
//  DwordleView.swift
//  dwordle
//
//  Created by Doug on 2/26/22.
//

import SwiftUI
import ComposableArchitecture

struct DwordleKeyView: View {
    let letter: Character
    let sendKey: (Character) -> Void
    
    var body: some View {
        Button(String(letter)) {
            sendKey(letter)
        }
    }
}

struct DwordleKeyboardRowView: View {
    let letters: [Character]
    let sendKey: (Character) -> Void
    
    var body: some View {
        HStack {
            ForEach(letters, id: \.self) {
                DwordleKeyView(letter: $0, sendKey: sendKey)
            }
        }
    }
}

struct DwordleKeyboardView: View {
    let sendKey: (Character) -> Void
    let sendEvaluate: () -> Void
    let sendDelete: () -> Void
    
    var body: some View {
        Self._printChanges()
        return VStack {
            DwordleKeyboardRowView(letters: "QWERTYUIOP".map {$0}, sendKey: sendKey)
            DwordleKeyboardRowView(letters: "ASDFGHJKL".map {$0}, sendKey: sendKey)
            HStack {
                Button("Enter") {
                    sendEvaluate()
                }
                DwordleKeyboardRowView(letters: "ZXCVBNM".map {$0}, sendKey: sendKey)
                Button {
                    sendDelete()
                } label: {
                    Image(systemName: "delete.left")
                }
            }
        }
    }
}


struct DwordleView: View {
    let store: Store<DwordleState, DwordleAction>
    @ObservedObject var viewStore: ViewStore<DwordleState, DwordleAction>
    
    init(store: Store<DwordleState, DwordleAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        Self._printChanges()
        return VStack {
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

