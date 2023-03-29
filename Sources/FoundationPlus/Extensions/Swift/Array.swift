//
//  Array.swift
//  
//
//  Created by Ben Myers on 2/19/22.
//

import Foundation

public extension Array {
  
  // MARK: - Public Methods
  
  /**
   Returns a random element based on the current day.
   
   - returns: A random element in the array
   */
  @inlinable func dayElement() -> Element? {
    let cal = Calendar.current
    let day = cal.component(.day, from: Date())
    let index = day % count
    if index < count {
      return self[index]
    } else {
      return nil
    }
  }
  
  // MARK: - Public Subscripts
  
  subscript(safe index: Int) -> Element? {
    guard index >= 0, index < endIndex else { return nil }
    return self[index]
  }
  
  subscript(wrap index: Int) -> Element {
    guard !isEmpty else { fatalError("[FoundationPlus] You can't wrap access an empty array!") }
    let wrapped = index % count
    return self[wrapped]
  }
  
  subscript(safeWrap index: Int) -> Element? {
    guard !isEmpty else { return nil }
    let wrapped = index % count
    return self[wrapped]
  }
}

public extension Array where Element: Equatable {
  
  // MARK: - Public Static Methods
  
  static func <= (lhs: inout Self, rhs: Element) {
    if !lhs.contains(rhs) {
      lhs.append(rhs)
    }
  }
  
  static func <= (lhs: inout Self, rhs: [Element]) {
    for item in rhs {
      lhs <= item
    }
  }
  
  static func -= (lhs: inout Self, rhs: Element) {
    lhs -= [rhs]
  }
  
  static func -= (lhs: inout Self, rhs: [Element]) {
    lhs.removeAll{ rhs.contains($0) }
  }
  
  static func - (lhs: [Element], rhs: [Element]) -> [Element] {
    var arr = lhs
    arr.removeAll(where: { rhs.contains($0) })
    return arr
  }
  
  // MARK: - Public Methods
  
  /**
   Appends an element to the array if it isn't in the array.
   
   - parameter newElement: The new element to add
   - parameter limit: The maxiumum amount of items the array can have
   */
  @inlinable mutating func appendUniquely(_ newElement: Element, limit: Int? = nil) {
    if !contains(newElement) {
      if let limit = limit {
        if count < limit {
          append(newElement)
        }
      } else {
        append(newElement)
      }
    }
  }
  
  /**
   Appends elements of an array to the array uniquely.
   
   - parameter newElements: The new elements to add
   - parameter condition: The condition to filter new unique elements with.
   */
  @inlinable mutating func appendUniquely<S>(
    contentsOf newElements: S,
    where condition: (S.Element) -> Bool = { _ in true }
  ) where Element == S.Element, S: Sequence {
    for element in newElements {
      if condition(element) {
        self.appendUniquely(element)
      }
    }
  }
  
  /**
   Inserts an element at the beginning of the array if it isn't in the array.
   
   - parameter newElement: The new element to insert
   - parameter limit: The maxiumum amount of items the array can have
   */
  @inlinable mutating func pushUniquely(_ newElement: Element, limit: Int? = nil) {
    if !contains(newElement) {
      insert(newElement, at: 0)
      if let limit = limit, count > limit {
        removeLast()
      }
    } else if let limit = limit {
      removeAll(of: newElement)
      insert(newElement, at: 0)
      while count > limit {
        removeLast()
      }
    }
  }
  
  /**
   Removes all instances of a provided element.
   
   - parameter match: The element to match
   */
  @inlinable mutating func removeAll(of match: Element) {
    self.removeAll(where: { $0 == match })
  }
  
  /**
   Picks random elements from the array.
   
   - parameter amount: The amount of random elements to pick
   - returns: An `Array` with the randomly picked elements.
   */
  @inlinable func pick(_ amount: Int) -> [Element] {
    var copy: [Element] = self
    var arr: [Element] = []
    guard count > 0 else { return [] }
    guard amount < count else { return self }
    for _ in 1 ... amount {
      let element = copy.randomElement()!
      arr.append(element)
      copy.removeAll(where: { $0 == element })
    }
    return arr
  }
  
  @inlinable func first(matching match: Element) -> Element? {
    self.first(where: { $0 == match })
  }
  
  @inlinable func last(matching match: Element) -> Element? {
    self.last(where: { $0 == match })
  }
}
