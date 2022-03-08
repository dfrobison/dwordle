//
//  View+Extension.swift
//  dwordle
//
//  Created by Doug on 3/2/22.
//

import SwiftUI

struct DwordleKey: ViewModifier {
    let width: CGFloat
    let keyColor: Color?
    
    func body(content: Content) -> some View {
        content
            .frame(maxHeight: .infinity)
            .frame(width: width)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                    .fill(keyColor ?? Color(UIColor.systemGray))
            )
    }
}

extension View {
    func dwordleKeyStyle(width: CGFloat, keyColor: Color? = nil) -> some View {
        modifier(DwordleKey(width: width, keyColor: keyColor))
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
