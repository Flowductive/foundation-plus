//
//  Date.swift
//  
//
//  Created by Ben Myers on 11/14/21.
//

import Foundation

@available(iOS 13.0, *)
public extension Date {
  
  // MARK: - Public Static Methods
  
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return rhs.distance(to: lhs)
  }
  
  // MARK: - Public Methods
  
  /**
   Formats the date.
   
   - parameter style: The format style, i.e. "h:MM"
   */
  func formatted(_ style: String, _ am: String = "AM", _ pm: String = "PM") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = style
    formatter.amSymbol = am
    formatter.pmSymbol = pm
    return formatter.string(from: self)
  }
}
