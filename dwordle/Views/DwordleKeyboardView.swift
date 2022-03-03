//
//  DwordleKeyboardView.swift
//  dwordle
//
//  Created by Doug on 3/2/22.
//

import SwiftUI


struct DwordleKeyView: View {
    let defaultButtonWidth = 30.0
    let letter: Character
    let sendKey: (Character) -> Void
    
    var body: some View {
        Button(String(letter)) {
            sendKey(letter)
        }
        .dwordleKeyStyle(width: defaultButtonWidth)
    }
}

struct DwordleKeyboardRowView: View {
    let defaultKeyboardRowHeight: CGFloat
    let letters: [Character]
    let sendKey: (Character) -> Void
    
    var body: some View {
        HStack {
            ForEach(letters, id: \.self) {
                DwordleKeyView(letter: $0, sendKey: sendKey)
            }
        }
        .frame(height: defaultKeyboardRowHeight)
    }
}

struct DwordleKeyboardView: View {
    let defaultKeyboardRowHeight = 30.0
    let sendKey: (Character) -> Void
    let sendEvaluate: () -> Void
    let sendDelete: () -> Void
    
    var body: some View {
        VStack {
            DwordleKeyboardRowView(defaultKeyboardRowHeight: defaultKeyboardRowHeight, letters: "QWERTYUIOP".map {$0}, sendKey: sendKey)
            DwordleKeyboardRowView(defaultKeyboardRowHeight: defaultKeyboardRowHeight, letters: "ASDFGHJKL".map {$0}, sendKey: sendKey)
            HStack {
                Button("Enter") {
                    sendEvaluate()
                }
                .dwordleKeyStyle(width: 60)

                DwordleKeyboardRowView(defaultKeyboardRowHeight: defaultKeyboardRowHeight, letters: "ZXCVBNM".map {$0}, sendKey: sendKey)
                Button {
                    sendDelete()
                } label: {
                    Image(systemName: "delete.left")
                        .dwordleKeyStyle(width: 45)
                }
                

            }
            .frame(height: defaultKeyboardRowHeight)
            .padding([.top], 2)
        }
    }
}
