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
  
  /**
   Returns whether the string is in the form of a valid email.
   
   - returns: Whether the string is a valid email.
   */
  func isValidEmail() -> Bool {
    let email = self
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}
