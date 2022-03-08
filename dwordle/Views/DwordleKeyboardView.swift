//
//  DwordleKeyboardView.swift
//  dwordle
//
//  Created by Doug on 3/2/22.
//

import SwiftUI
import ComposableArchitecture


struct DwordleKeyView: View {
    let defaultButtonWidth = 30.0
    let letter: Character
    let keyEvaluation: CellEvaluation?
    let sendKey: (Character) -> Void
    
    var body: some View {
        Button(String(letter)) {
            sendKey(letter)
        }
        .dwordleKeyStyle(width: defaultButtonWidth, keyColor: keyEvaluation?.color)
    }
}

struct DwordleKeyboardRowView<LeftView: View, RightView: View> : View {
    let keyboardRowHeight: CGFloat = 45.0
    let letters: [Character]
    let keys: DwordleState.KeyEvaluation
    let sendKey: (Character) -> Void
    @ViewBuilder let leftView: LeftView
    @ViewBuilder let rightView: RightView

    
    var body: some View {
        HStack {
            leftView
            
            ForEach(letters, id: \.self) {
                DwordleKeyView(letter: $0, keyEvaluation: keys[$0], sendKey: sendKey)
            }
            
            rightView
        }
        .frame(height: keyboardRowHeight)
    }
}

struct DwordleKeyboardView: View {
    @ObservedObject var viewStore: ViewStore<DwordleState, DwordleAction>

    var body: some View {
        VStack {
            createKeyRow("QWERTYUIOP")
            createKeyRow("ASDFGHJKL")
            createKeyRow("ZXCVBNM") {
                Button("Enter") {
                    viewStore.send(.evaluate)
                }
                .dwordleKeyStyle(width: 50)
                
            } rightContent: {
                Button {
                    viewStore.send(.backspace)
                } label: {
                    Image(systemSymbol: .deleteLeft)
                        .dwordleKeyStyle(width: 50)
                }
            }
        }
        .disabled(!viewStore.canPlay)
    }
    
    @ViewBuilder
    private func createKeyRow(_ letters: String) -> some View {
        createKeyRow(letters) { EmptyView() } rightContent: { EmptyView() }
    }
    
    @ViewBuilder
    private func createKeyRow<LeftContent: View, RightContent: View>(_ letters: String,
                                                                     @ViewBuilder leftContent: () -> LeftContent,
                                                                     @ViewBuilder rightContent: () -> RightContent) -> some View {
        DwordleKeyboardRowView(letters: letters.map {$0},
                               keys: viewStore.keys,
                               sendKey: { viewStore.send(.addLetter($0)) },
                               leftView: leftContent,
                               rightView: rightContent)
    }
}
