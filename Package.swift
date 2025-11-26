// swift-tools-version: 6.2
// Copyright Ryan Francesconi. All Rights Reserved. Revision History at https://github.com/ryanfrancesconi

import PackageDescription

private let name: String = "SPFKTesting" // Swift target

private let platforms: [PackageDescription.SupportedPlatform]? = [
    .macOS(.v12)
]

private let products: [PackageDescription.Product] = [
    .library(
        name: name,
        targets: [name]
    )
]

private let targets: [PackageDescription.Target] = [
    // Swift
    .target(
        name: name,
        dependencies: [],
        resources: [
            .process("Resources") // all test files should be in here
        ]
    ),

    .testTarget(
        name: "\(name)Tests",
        dependencies: [
            .byNameItem(name: name, condition: nil)
        ]
    )
]

let package = Package(
    name: name,
    defaultLocalization: "en",
    platforms: platforms,
    products: products,
    targets: targets,
    cxxLanguageStandard: .cxx20
)
