//
//  TimeInterval.swift
//  
//
//  Created by Ben Myers on 11/14/21.
//

import Foundation

public extension TimeInterval {
  
  // MARK: - Properties
  
  /// The interval, in seconds.
  var seconds: Int {
    return Int(self)
  }
  
  /// The interval, in minutes.
  var minutes: Int {
    return seconds / 60
  }
  
  /// The interval, in hours.
  var hours: Int {
    return minutes / 60
  }
  
  /// The interval, in days.
  var days: Int {
    return hours / 24
  }
  
  /// A formatted version of the `TimeInterval` with a colon.
  var formattedColon: String {
    let hours = minutes / 60
    let minutes = minutes % 60
    let seconds = seconds % 60
    var str = ""
    if hours > 0 {
      str.append("\(hours):")
      if minutes >= 10 {
        str.append("\(minutes):")
      } else {
        str.append("0\(minutes):")
      }
    } else {
      str.append("\(minutes):")
    }
    if seconds >= 10 {
      str.append("\(seconds)")
    } else {
      str.append("0\(seconds)")
    }
    return str
  }
  
  // MARK: - Methods
  
  /**
   A formatted version of the `TimeInterval`.
   
   - parameter mode: The styling mode to use
   - returns: The `TimeInterval`, formatted
   */
  func formatted(_ mode: FormattingMode = .short) -> String {
    if self < 0 {
      return "∞"
    }
    if self >= 1.days {
      return "\(days)\(mode.day(days != 1))"
    }
    if self == 0 {
      return "0\(mode.minute(true))"
    }
    let hours = minutes / 60
    let remainingMin = minutes % 60
    var str = ""
    if hours > 0 { str.append("\(hours)\(mode.hour(hours != 1))") }
    if hours > 0 && remainingMin > 0 { str.append(" ") }
    if remainingMin > 0 { str.append("\(remainingMin)\(mode.minute(minutes != 1))")}
    return str
  }
  
  // MARK: - Enumerations
  
  enum FormattingMode {
    
    case short, medium, full
    
    func day(_ s: Bool) -> String {
      switch self {
      case .short: return "d"
      case .medium: return " day\(s ? "s" : "")"
      case .full: return " day\(s ? "s" : "")"
      }
    }
    
    func hour(_ s: Bool) -> String {
      switch self {
      case .short: return "h"
      case .medium: return " hr"
      case .full: return " hour\(s ? "s" : "")"
      }
    }
    
    func minute(_ s: Bool) -> String {
      switch self {
      case .short: return "m"
      case .medium: return " min"
      case .full: return " minute\(s ? "s" : "")"
      }
    }
  }
}

