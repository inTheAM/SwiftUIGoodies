// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftUIGoodies",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "SwiftUIGoodies",
            targets: ["SwiftUIGoodies"]),
    ],
    targets: [
        .target(
            name: "SwiftUIGoodies",
            dependencies: []),
        .testTarget(
            name: "SwiftUIGoodiesTests",
            dependencies: ["SwiftUIGoodies"]),
    ]
)
