//
//  DayPart.swift
//  
//
//  Created by Ben Myers on 2/19/22.
//

import Foundation

public enum DayPart {
  
  /// 5-9 AM.
  case morning
  /// 9-12 AM.
  case midday
  /// 12-5 PM.
  case afternoon
  /// 5-8 PM.
  case evening
  /// 8 PM-12 AM.
  case night
  /// 12-5 AM
  case midnight
  
  // MARK: - Public Properties
  
  /// An associated emoji for the day part.
  public var emoji: String {
    switch self {
    case .morning: return "🌱"
    case .midday: return "☀️"
    case .afternoon: return "⛅️"
    case .evening: return "🌙"
    case .night: return "🌒"
    case .midnight: return "✨"
    }
  }
  
  /// An associated greeting for the day part.
  public var greeting: String {
    switch self {
    case .morning: return "An early start!"
    case .midday: return "Good morning!"
    case .afternoon: return "Good afternoon!"
    case .evening: return "Good evening!"
    case .night: return "Good evening!"
    case .midnight: return "Up this late?"
    }
  }
  
  // MARK: - Public Static Methods
  
  /**
   Gets the day part from a provided dart.
   */
  public static func get(from date: Date) -> Self {
    let hour = date.hour
    if (5 ... 8).contains(hour) {
      return .morning
    } else if (9 ... 11).contains(hour) {
      return .midday
    } else if (12 ... 17).contains(hour) {
      return .afternoon
    } else if (17 ... 19).contains(hour) {
      return .evening
    } else if (20 ... 23).contains(hour) {
      return .night
    } else {
      return .midnight
    }
  }
}
