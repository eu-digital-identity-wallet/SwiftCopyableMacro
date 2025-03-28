// swift-tools-version: 6.0.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "Copyable",
  platforms: [
    .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)
  ],
  products: [
    .library(
      name: "Copyable",
      targets: ["Copyable"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "509.0.0")
  ],
  targets: [
    .macro(
      name: "CopyableMacro",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .target(
      name: "Copyable",
      dependencies: ["CopyableMacro"]
    )
  ]
)

