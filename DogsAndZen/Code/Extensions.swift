//
//  Extensions.swift
//  DogsAndZen
//
//  Created by John Price on 4/23/24.
//

import Foundation
import SwiftUI

extension Date {
  /// Determines the first day of the month for the date.
  ///
  /// - Returns: The first day of the month.
  func startOfMonth() -> Date {
    return Calendar.current.date(
      from: Calendar.current.dateComponents(
        [.year, .month, .day], from: Calendar.current.startOfDay(for: self)))!
  }

  /// Determines the last day of the month for the date.
  ///
  /// - Returns: The last day of the month.
  func endOfMonth() -> Date {
    return Calendar.current.date(
      byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
  }
}

extension Animation {
  /// Repeats an animation while `expression` is true.
  ///
  /// - Parameters:
  ///   - expression: The expression to evaluate.
  ///   - autoreverse: Whether or not to reverse the animation.
  ///
  /// - Returns: The animation.
  func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
    if expression {
      return self.repeatForever(autoreverses: autoreverses)
    } else {
      return self
    }
  }
}
