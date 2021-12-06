//
//  String.swift
//  
//
//  Created by Ben Myers on 12/5/21.
//

import Foundation

public extension String {
  
  // MARK: - Public Methods
  
  /**
   Repeats the contents of the String.
   
   - parameter count: The amount of times to repeat the string.
   - returns: The string, repeated.
   */
  func repeated(_ count: Int) -> String {
    let clone = self
    var new = ""
    guard count > 0 else { return "" }
    for _ in 0 ... count - 1 {
      new += clone
    }
    return new
  }
}
