//
//  View+Extension.swift
//  dwordle
//
//  Created by Doug on 3/2/22.
//

import SwiftUI

struct DwordleKey: ViewModifier {
    let width: CGFloat
    
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
                .fill(Color.blue)
            )
    }
}

extension View {
    func dwordleKeyStyle(width: CGFloat) -> some View {
        modifier(DwordleKey(width: width))
    }
}
