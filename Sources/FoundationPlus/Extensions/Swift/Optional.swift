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
