//
//  String.swift
//  
//
//  Created by Ben Myers on 12/5/21.
//

import Foundation

public extension String {
  
  // MARK: - Public Properties
  
  /// A version of the string that is only alphanumeric.
  var alphanumeric: String {
    return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
  }
  
  /// The first word in the string.
  var firstWord: String {
    return components(separatedBy: " ").first ?? ""
  }
  
  // MARK: - Static Methods
  
  /**
   Returns a random string in the given character set.
   */
  static func random(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
  }
  
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
  
  /**
   Gets a version of the string that is only alphanumeric, with additional provided characters.
   
   - parameter otherChars: The other characters to allow in the string.
   - returns: The string, with only alphanumeric and allowed characters.
   */
  func alphernumeric(with otherChars: Unicode.Scalar ...) -> String {
    let otherSet: CharacterSet = CharacterSet(otherChars)
    return self.components(separatedBy: CharacterSet.alphanumerics.union(otherSet).inverted).joined()
  }
}
