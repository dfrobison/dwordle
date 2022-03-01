//
//  DwordleGridView.swift
//  dwordle
//
//  Created by Doug on 2/28/22.
//

import SwiftUI

struct DwordleGridView<Content: View>: View {
    typealias GridItemFactory = (_ row: Int, _ column: Int) -> Content
    
    let width: Int
    let height: Int
    let spacing: CGFloat
    let gridItemFactory: GridItemFactory
    
    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: width)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
            ForEach(0..<height) { row in
                ForEach(0..<width) { column in
                    gridItemFactory(row, column)
                }
            }
        }
    }
}


struct DwordleGridView__Previews: PreviewProvider {
    static var previews: some View {
        DwordleGridView(width: 5, height: 6, spacing: 8) { row, column in
            DwordleCellView(cell: DwordleCell(letter: .init("A"), evalation: nil))
        }
        .padding()
    }
}
