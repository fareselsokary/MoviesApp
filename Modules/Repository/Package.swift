// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data", // This is your Repository module
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../API"),        // For API models and services
        .package(path: "../Domain"),     // For domain models (input/output)
        .package(path: "../Networking"), // For NetworkError, NetworkServiceProtocol
        .package(path: "../Persistence"),// For CacheManagerProtocol, Cached models
        .package(path: "../Core"),       // For NetworkReachability, Logger
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                "API",
                "Domain",
                "Networking",
                "Persistence",
                "Core"
            ],
            path: "Sources/Data"
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            path: "Tests/DataTests"
        ),
    ]
)
