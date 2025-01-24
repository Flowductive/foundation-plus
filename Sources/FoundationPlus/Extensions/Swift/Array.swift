//
//  Array.swift
//  
//
//  Created by Ben Myers on 2/19/22.
//

import Foundation

// MARK: - Subscripts

public extension Array {
  
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

@available(iOS 13.0, *)
public extension Array where Element: Identifiable {
  
  subscript (id id: Element.ID) -> Element? {
    return first(where: { $0.id == id })
  }
}

// MARK: - Array

public extension Array {
  
  func capped(max: Int?) -> Self {
    if let max {
      return Array(self[0 ..< Swift.min(count, max)])
    } else {
      return self
    }
  }
}

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
}

// MARK: - Equatable

public extension Array where Element: Equatable {
  
  // MARK: - Public Static Methods
  
  @available(*, deprecated: 2.0, message: "<= is deprecated. Use `if !lhs.contains(rhs) { lhs.append(rhs) }` instead.")
  static func <= (lhs: inout Self, rhs: Element) {
    if !lhs.contains(rhs) {
      lhs.append(rhs)
    }
  }
  
  @available(*, deprecated: 2.0, message: "<= is deprecated. Use `if !lhs.contains(rhs) { lhs.append(rhs) }` instead.")
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

public extension Array where Element: Equatable {
  
  @discardableResult
  mutating func replace(_ element: Element, with new: Element) -> Bool {
    if let f = self.firstIndex(where: { $0 == element}) {
      self[f] = new
      return true
    }
    return false
  }
}

// MARK: - Identifiable

@available(iOS 13.0, *)
public extension Array where Element: Identifiable {
  
  mutating func submit(contentsOf new: [Element]) {
    for item in new {
      if let index = self.firstIndex(where: { $0.id == item.id }) {
        self[index] = item
      } else {
        self.append(item)
      }
    }
  }
  
  mutating func submit(_ item: Element) {
    submit(contentsOf: [item])
  }
  
  mutating func submit(contentsOf new: [Element], at index: Int) {
    for item in new.reversed() {
      if let index = self.firstIndex(where: { $0.id == item.id }) {
        self[index] = item
      } else {
        self.insert(item, at: index)
      }
    }
  }
  
  mutating func submit(_ item: Element, at index: Int) {
    submit(contentsOf: [item], at: index)
  }
}

// MARK: - Async

public extension Sequence {
  
  func map<T>(path: KeyPath<Element, T>) -> [T] {
    self.map({ $0[keyPath: path] })
  }
  
  func asyncMap<T>(
    _ transform: (Element) async throws -> T
  ) async rethrows -> [T] {
    var values = [T]()
    
    for element in self {
      try await values.append(transform(element))
    }
    
    return values
  }
}

// MARK: - Hashable

public extension Array where Element: Hashable {
  
  func uniqued() -> Array {
    var buffer = Array()
    var added = Set<Element>()
    for elem in self {
      if !added.contains(elem) {
        buffer.append(elem)
        added.insert(elem)
      }
    }
    return buffer
  }
}
