//
//  Equatable.swift
//  FoundationPlus
//
//  Created by Ben Myers on 1/3/25.
//

import Foundation

public extension Equatable {
  
  /// Returns whether this object is in a specified array.
  func isContainedIn(_ array: [Self]) -> Bool {
    return array.contains(self)
  }
  
  /// Returns whether this objects is any of the listed items.
  func isAnyOf(_ items: Self...) -> Bool {
    return items.contains(self)
  }
  
  /// Returns false if this objects is in any of the listed items.
  func isNotAnyOf(_ items: Self...) -> Bool {
    return !items.contains(self)
  }
}
