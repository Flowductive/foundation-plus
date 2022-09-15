//
//  Optional.swift
//  
//
//  Created by Ben Myers on 5/18/22.
//

import Foundation

infix operator =?: AssignmentPrecedence
infix operator ==?: ComparisonPrecedence
infix operator !=?: ComparisonPrecedence

extension Optional {
  
  /**
   Optionally assigns the right-hand side of an expression to the left-hand side, if `rhs` is non-nil.
   
   - parameter lhs: The item to be assigned a value
   - parameter rhs: The value to assign to the item
   */
  public static func =? (lhs: inout Wrapped, rhs: Wrapped?) {
    if let rhs = rhs {
      lhs = rhs
    }
  }
}

extension Optional where Wrapped: Equatable {
  
  /**
   Optionally checks if an optional values are equal.
   
   This will always pass false if either side of the operator have a `nil` value.
   
   - parameter lhs: The left-hand side optional
   - parameter rhs: The right-hand side optional
   */
  public static func ==? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
      return lhs == rhs
    } else {
      return false
    }
  }
  
  /**
   Optionally checks if an optional values are not equal.
   
   This will always pass true if either side of the operator have a `nil` value.
   
   - parameter lhs: The left-hand side optional
   - parameter rhs: The right-hand side optional
   */
  public static func !=? (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
      return lhs != rhs
    } else {
      return true
    }
  }
}

extension Optional where Wrapped: CustomStringConvertible {
  
  /**
   Optionally unwraps a String and returns an empty string if the value is `nil`.
   
   - parameter transform: The string to return, provided an unwrapped version of the non-optional string value.
   - parameter or: The backup string to provide in the case the wrapped value is `nil`.
   - returns: The unwrapped or backup string.
   */
  public func ifLet(transform: (Wrapped) -> String = { String(describing: $0) }, or: String = "") -> String {
    if let value = self {
      return transform(value)
    } else {
      return or
    }
  }
}
