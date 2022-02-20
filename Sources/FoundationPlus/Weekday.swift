//
//  Weekday.swift
//
//
//  Created by Ben Myers on 6/16/21.
//

import Foundation

public enum Weekday: Int, Codable {
  case sunday = 0, monday = 1, tuesday = 2, wednesday = 3, thursday = 4, friday = 5, saturday = 6
  
  // MARK: - Public Properties
  
  /// A string representing the weekday.
  public var string: String {
    switch self {
    case .sunday: return "Sunday"
    case .monday: return "Monday"
    case .tuesday: return "Tuesday"
    case .wednesday: return "Wednesday"
    case .thursday: return "Thursday"
    case .friday: return "Friday"
    case .saturday: return "Saturday"
    }
  }
  
  /// A shorthand string of the first three letters of the weekday.
  public var shortString: String {
    return String(string.prefix(3))
  }
  
  /// An abbreviation string for the weekday.
  public var singleString: String {
    if self == .thursday {
      return "R"
    } else if self == .sunday {
      return "U"
    } else {
      return String(string.prefix(1))
    }
  }
  
  // MARK: - Public Static Methods
  
  /**
   Gets the weekday from a given date.
   
   - parameter date: The date to retrieve the weekday from.
   */
  public static func get(from date: Date) -> Weekday {
    let calendar = Calendar.current
    let num = calendar.component(.weekday, from: date)
    return get(fromGregorian: num)
  }
  
  /**
   Gets the weekday from a Gregorian calendar weekday value.
   
   - parameter date: The date to retrieve the weekday from.
   */
  public static func get(fromGregorian val: Int) -> Weekday {
    switch val {
    case 1: return .sunday
    case 2: return .monday
    case 3: return .tuesday
    case 4: return .wednesday
    case 5: return .thursday
    case 6: return .friday
    case 7: return .saturday
    default: return .sunday
    }
  }
}
