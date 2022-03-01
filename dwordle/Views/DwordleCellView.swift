//
//  DwordleCellView.swift
//  dwordle
//
//  Created by Doug on 2/28/22.
//

import SwiftUI

extension CellEvaluation {
    var color: Color {
        switch self {
        case .miss:
            return Color(.systemGray5)
        case .included:
            return Color(.systemYellow)
        case .exact:
            return Color(.systemGreen)
        }
    }
}





struct DwordleCellView: View {
    let cell: DwordleCell
    
    private var cellColor: Color {
        guard let evaluation = cell.evalation else {
            return .dwordleCellBackground
        }
        
        return evaluation.color
    }
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 4)
                .style(withStroke: Color.black, lineWidth: 1, fill: cellColor)
                .aspectRatio(1, contentMode: .fit)
            
            if let letter = cell.letter {
                Text(String(letter))
                    .font(.system(size: 36, weight: .bold, design: .rounded))
           }
        }
    }
    
}

struct DwordleCellView_Previews: PreviewProvider {
    static var previews: some View {
        DwordleCellView(cell: DwordleCell(letter: .init("A"), evalation: nil))
            .previewLayout(.fixed(width: 100, height: 100))
            .environment(\.colorScheme, .light)
        DwordleCellView(cell: DwordleCell(letter: .init("A"), evalation: nil))
            .previewLayout(.fixed(width: 100, height: 100))
            .environment(\.colorScheme, .dark)
        DwordleCellView(cell: DwordleCell(letter: .init("A"), evalation: .included))
            .previewLayout(.fixed(width: 100, height: 100))
            .environment(\.colorScheme, .light)
        DwordleCellView(cell: DwordleCell(letter: .init("A"), evalation: .miss))
            .previewLayout(.fixed(width: 100, height: 100))
            .environment(\.colorScheme, .light)
        DwordleCellView(cell: DwordleCell(letter: .init("A"), evalation: .exact))
            .previewLayout(.fixed(width: 100, height: 100))
            .environment(\.colorScheme, .dark)

    }
}
