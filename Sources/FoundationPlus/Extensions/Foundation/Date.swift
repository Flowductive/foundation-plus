//
//  Date.swift
//  
//
//  Created by Ben Myers on 11/14/21.
//

import Foundation

@available(iOS 13.0, *)
public extension Date {
  
  // MARK: - Static Methods
  
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return rhs.distance(to: lhs)
  }
}
