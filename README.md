![Social Preview](./Assets/Social%20Preview%20(640).png)

<h2 align="center">Basic Swift extensions that make life easier.</h2>

<p align="center">🪶 Lightweight, Swift-y looking code for modern SwiftUI developers</p>
<p align="center">🧩 Useful methods and properties written in native Swift</p>

***

⚠️ **Note:** This package is still under development and its contents are freely subject to change.

🚧 **Wiki under construction.** Read below to get started!

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Flowductive/foundation-plus?label=version)
![GitHub Release Date](https://img.shields.io/github/release-date/Flowductive/foundation-plus?label=latest%20release)
![GitHub issues](https://img.shields.io/github/issues/Flowductive/foundation-plus)
![GitHub pull requests](https://img.shields.io/github/issues-pr/Flowductive/foundation-plus)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFlowductive%2Feasy-firebase%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Flowductive/foundation-plus)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFlowductive%2Feasy-firebase%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Flowductive/foundation-plus)

## What is FoundationPlus?

FoundationPlus is a suite of basic Swift extensions that help speed up the process of app development, and help make your code look nicer. Functions that you'll normally need, like methods to check the app's version, get the current day of week, and so on, can have convoluted code. FoundationPlus simplifies these with built-in extensions.

```swift
// 😴 Before
let interval = TimeInterval(9945)

// ✨ After
let interval = 2.hours + 45.minutes + 45.seconds
```

```swift
// 😴 Before
if let value = optionalValue {
  myVar = value
} else {
  myVar = nil
}

// ✨ After
myVar =? optionalValue
```

```swift
// 😴 Before
if array.count >= 5 {
  myVar = array[4]
}

// ✨ After
myVar = array[safe: 4]
```

## Completed Features

- Extensions
  - Date and TimeInterval extensions [→](https://github.com/Flowductive/foundation-plus#date-and-timeinterval-extensions)
  - Array extensions [→](https://github.com/Flowductive/foundation-plus#array-extensions)
  - Optional extensions [→](https://github.com/Flowductive/foundation-plus#optional-extensions)
  - String extensions [→](https://github.com/Flowductive/foundation-plus#string-extensions)
- Other Features
  - Open URL action [→](https://github.com/Flowductive/foundation-plus#open-url-action)
  - Get part of day and weekday [→](https://github.com/Flowductive/foundation-plus#get-part-of-day-and-weekday)

Most of the above features are **cross-platform** and are supported on iOS, macOS, tvOS and watchOS.

## Get Started

Add **FoundationPlus** to your project using Swift Package Manager:

```
https://github.com/Flowductive/foundation-plus
```

## 🧩 Extensions

### Date and TimeInterval extensions

Get `TimeIntervals` easily:

```swift
let interval = 10.minutes
let interval2 = 4.days
```

Format `TimeInterval`s:

```swift
print(3.hours.formattedColon) // 3:00
print((2.minutes + 30.seconds).formatted(.short)) // 2m 30s
print(4.hours.formatted(.full)) // 4 hours
```

Get the current month, day, hour, minute, etc:

```swift
let date = Date()
let dateFormatted = "The current time is \(date.hour) : \(date.minute)."
```

Get a date moved forward to right before midnight:

```swift
let thisEvening = date.atMidnight
```

Get formatted versions of the date:

```swift
print(date.shorthand) // 6/7/22
print(date.longhand) // Tuesday, June 07, 2022
```

Subtract dates and get a `TimeInterval`:

```swift
let timeBetween = laterDate - earlierDate
```

Get the next/preview occurence of a specific weekday:

```swift
let nextTuesday = Date().next(.tuesday)
let lastWednesday = Date().previous(.wednesday, considerToday: false)
```

Get a string representing how long it's been since the `Date`:

```swift
print(lastWednesday.timeAgoSince()) // 2 days ago
```

### Array extensions

Safely subscript arrays, and even wrap array indices:

```swift
let myString = ["a", "b", "c", "d"]
let myString: String = myStrings[safe: 5] ?? "-" // "-"
let myString2: String = myString[wrap: 5] // "b"
```

Use new operators on arrays:

```swift
var array: [1, 2, 3]

// Add the element(s) if it is not inside
array <= 4 // [1, 2, 3, 4]
array <= 2 // [1, 2, 3, 4]
array <= [4, 5] // [1, 2, 3, 4, 5]

// Remove elements
array -= 1 // [2, 3, 4, 5]
array -= [2, 3, 6] // [4, 5]
```

Use additional methods on arrays:

```swift
let array = [1, 2, 3, 3]
// Add to the end if not already in the array
array.appendUniquely(5) // [1, 2, 3, 3, 5]
// Add to the beginning if not already in the array
array.pushUniquely(0) // [0, 1, 2, 3, 3, 5]
// Remove all of an element
array.removeAll(3) // [0, 1, 2, 5]
// Pick a random bunch of elements
array.pick(2) // [0, 2]
```

### Optional extensions

Optionally assign the right-hand side to the left-hand side if non-`nil`:

```swift
var str: String = "Hello World"
var optionalStr: String? = nil
str =? optionalStr // Only sets str if myOptionalString is non-nil
print(str) // "Hello, world"
```

Optionally check if two `Optional` or non-`Optional` values are equal/nonequal, and return `false` for equality and `true` for inequality if either value is `nil`:

```swift
let areEqual: Bool { nil ==? 4 } // False
let areNonEqual: Bool { 4 !=? 3 } // True
```

### String extensions

Return only alpha-numeric parts of a String:

```swift
let alphanumeric = "Abc123+-=~".alphanumeric // "Abc123"
```

Return the first word of a String:

```swift
let first = "Hello World!".firstWord // "Hello"
```

Get a random alphanumeric string with a specified length:

```swift
let random = String.random(16) // "b7vb92Fg9FEN2g8A"
```

Repeat a String:

```swift
let repeated = "Hi".repeat(5) // "HiHiHiHiHi"
```

Check if a String is a valid email:

```swift
let isEmailValid: Bool = "test@hi.com".isValidEmail() // True
```

## ✨ Other Features

### Get URL action

Quickly open a URL in iOS or macOS:

```swift
myUrl.open()
```

### Get part of day and weekday

Grab information regarding the time of day:

```swift
let part = DayPart.get(from: Date()) // Chooses automatically from .morning, .midday, .afternoon, .evening, .night, and .midnight
print(part.greeting) // "Good morning!"
