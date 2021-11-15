// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FoundationPlus",
  platforms: [.iOS(.v11), .macOS(.v10_15), .tvOS(.v12), .watchOS(.v7)],
  products: [
    .library(
      name: "FoundationPlus",
      targets: ["FoundationPlus"]),
  ],
  targets: [
    .target(
      name: "FoundationPlus"
    )
  ]
)
