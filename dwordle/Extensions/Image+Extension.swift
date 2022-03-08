//
//  Image+Extension.swift
//  Tally
//
//  Created by Doug on 12/3/20.
//
import SwiftUI

public extension SwiftUI.Image {
    
    /// Creates a instance of `Image` with a system symbol image of the given type.
    ///
    /// - Parameter systemSymbol: The `SFSymbol` describing this image.
    init(systemSymbol: SFSymbol) {
        self.init(systemName: systemSymbol.rawValue)
    }
}
