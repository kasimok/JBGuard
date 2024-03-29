// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "JBGuard",
  platforms: [
    .iOS(.v13),
    .tvOS(.v13),
    // macOS does not have common sense `jailbreak`
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "JBGuard",
      targets: ["JBGuard"])
  ],
  targets: [
    
    .target(
      name: "JBGuard", dependencies: ["disable_attach"]),
    .target(name: "disable_attach")
  ]
)
