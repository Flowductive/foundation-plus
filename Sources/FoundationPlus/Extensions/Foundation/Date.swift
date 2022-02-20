//
//  Date.swift
//  
//
//  Created by Ben Myers on 11/14/21.
//

import Foundation

@available(iOS 13.0, *)
public extension Date {
  
  // MARK: - Public Properties
  
  /// The date, as a month
  var month: Int {
    return Calendar.current.component(.month, from: self)
  }
  
  /// The date, as a weekday
  var weekday: Int {
    return Calendar.current.component(.weekday, from: self)
  }
  
  /// The date, as a singular day
  var day: Int {
    return Calendar.current.component(.day, from: self)
  }
  
  /// The date, as an hour
  var hour: Int {
    return Calendar.current.component(.hour, from: self)
  }
  
  /// The date, as a minute
  var minute: Int {
    return Calendar.current.component(.minute, from: self)
  }
  
  /// The date, set to the latest possible time (right before midnight)
  var atMidnight: Date {
    let cal = Calendar.current
    let date = self
    return cal.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
  }
  
  /// A shorthand string for the date relative to today
  var relativeShorthand: String {
    let cal = Calendar.current
    let date = self
    let amount = cal.dateComponents([.day], from: Date(), to: date).day
    guard let amount = amount else { return shorthand }
    switch amount {
    case 0:
      let timeLeft = self - Date()
      if timeLeft <= 0 { return "today" }
      return "in \(timeLeft.formatted(.medium))"
    case 1: return "tomorrow"
    default:
      if amount < 6 {
        return Weekday.get(from: self).string
      } else {
        return shorthand
      }
    }
  }
  
  /// A long string for the date
  var longhand: String {
    let format = DateFormatter()
    format.dateFormat = "EEEE, MMMM dd, yyyy"
    return format.string(from: self)
  }
  
  /// A shorthand string for the date
  var shorthand: String {
    let format = DateFormatter()
    format.dateStyle = .short
    return format.string(from: self)
  }
  
  /// A shorthand set of strings for the day and month of the date
  var dayMonth: (String, String) {
    let format1 = DateFormatter(), format2 = DateFormatter()
    format1.dateFormat = "dd"
    format2.dateFormat = "MMM"
    let str1 = format1.string(from: self)
    let str2 = format2.string(from: self)
    return (str1, str2)
  }
  
  /// A shorthand set of strings for the hour/minute and meridian of the date
  var hourMinuteMeridian: (String, String) {
    let format1 = DateFormatter(), format2 = DateFormatter()
    format1.dateFormat = "h:mm"
    format2.dateFormat = "a"
    let str1 = format1.string(from: self)
    let str2 = format2.string(from: self)
    return (str1, str2)
  }
  
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
  
  /**
   Sets the current date to the next instance of 11:59pm.
   */
  mutating func setToMidnight() {
    let cal = Calendar.current
    let date = self
    self = cal.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
  }
  
  /**
   Gets the next occurence of a certain weekday.
   
   - parameter weekday: The weekday to search for
   - parameter considerToday: Whether today should be considered
   - returns: The date on the next given weekday
   */
  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }
  
  /**
   Gets the previous occurence of a certain weekday.
   
   - parameter weekday: The weekday to search for
   - parameter considerToday: Whether today should be considered
   - returns: The date on the previous given weekday
   */
  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }
  
  /**
   Gets a `String` that represents the amount of time ago since the date.
   
   - returns: A `String` representing the amount of time since the date
   */
  func timeAgoSince() -> String {
    let date = self
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    if let year = components.year, year >= 2 {
      return "\(year) years ago"
    }
    if let year = components.year, year >= 1 {
      return "Last year"
    }
    if let month = components.month, month >= 2 {
      return "\(month) months ago"
    }
    if let month = components.month, month >= 1 {
      return "Last month"
    }
    if let week = components.weekOfYear, week >= 2 {
      return "\(week) weeks ago"
    }
    if let week = components.weekOfYear, week >= 1 {
      return "Last week"
    }
    if let day = components.day, day >= 2 {
      return "\(day) days ago"
    }
    if let day = components.day, day >= 1 {
      return "Yesterday"
    }
    if let hour = components.hour, hour >= 2 {
      return "\(hour) hours ago"
    }
    if let hour = components.hour, hour >= 1 {
      return "An hour ago"
    }
    if let minute = components.minute, minute >= 2 {
      return "\(minute) minutes ago"
    }
    if let minute = components.minute, minute >= 1 {
      return "A minute ago"
    }
    if let second = components.second, second >= 3 {
      return "\(second) seconds ago"
    }
    return "Just now"
  }
  
  // MARK: - Private Methods
  
  private func get(_ direction: SearchDirection,
                   _ weekDay: Weekday,
                   considerToday consider: Bool = false) -> Date {
    
    let dayName = weekDay.string.lowercased()
    
    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
    
    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
    
    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
    
    let calendar = Calendar(identifier: .gregorian)
    
    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }
    
    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex
    
    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)
    
    return date!
  }
  
  private func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }
  
  // MARK: - Enumerators
  
  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}
