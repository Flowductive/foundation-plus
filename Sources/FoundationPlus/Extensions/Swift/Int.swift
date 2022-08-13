//
//  Int.swift
//  
//
//  Created by Ben Myers on 11/14/21.
//

import Foundation

public extension Int {
  
  // MARK: - Properties
  
  /// The value, as a `TimeInterval`, provided that the value is in seconds
  var seconds: TimeInterval {
    return TimeInterval(self)
  }
  
  /// The value, as a `TimeInterval`, provided that the value is in minutes
  var minutes: TimeInterval {
    return 60 * seconds
  }
  
  /// The value, as a `TimeInterval`, provided that the value is in hours
  var hours: TimeInterval {
    return 60 * minutes
  }
  
  /// The value, as a `TimeInterval`, provided that the value is in hours
  var days: TimeInterval {
    return 24 * hours
  }
  
  /// The value, as a `TimeInterval`, provided that the value is in hours
  var weeks: TimeInterval {
    return 7 * days
  }
  
  /// A value plural.
  var s: String {
    if self == 1 { return "" } else { return "s" }
  }
  
  /// A string of the number with commas.
  var withCommas: String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
  }
}
