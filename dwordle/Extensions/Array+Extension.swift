//
//  Array+Extension.swift
//  dwordle
//
//  Created by Doug on 2/28/22.
//

extension Array where Element == CellEvaluation {
    var solved: Bool {
        allSatisfy { $0 == .exact }
    }
}
