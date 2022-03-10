//
//  TimeFormatter.swift
//  dwordle
//
//  Created by Doug on 3/9/22.
//

import Foundation

let timeFormatter: DateComponentsFormatter = {
  let formatter = DateComponentsFormatter()
  formatter.allowedUnits = [.minute, .second]
  formatter.zeroFormattingBehavior = .pad
  return formatter
}()
