//
//  SwiftUIView.swift
//  
//
//  Created by Ben Myers on 11/14/21.
//

import Foundation

public typealias DateRange = ClosedRange<Date>

@available(iOS 13.0, macOS 10.15, *)
public extension ClosedRange where Bound == Date {
  
  // MARK: - Properties
  
  /// The time interval between two dates in a closed range.
  var difference: TimeInterval {
    lowerBound.distance(to: upperBound)
  }
}
