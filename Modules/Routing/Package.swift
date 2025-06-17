// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Routing",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Routing",
            targets: ["Routing"]),
    ],
    dependencies: [
        // Routing layer might need access to domain models to define navigation parameters
        .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Routing",
            dependencies: [
                "Domain" // Depends on Domain for defining navigation parameters (e.g., movieId)
            ],
            path: "Sources/Routing"
        ),
        .testTarget(
            name: "RoutingTests",
            dependencies: ["Routing"],
            path: "Tests/RoutingTests"
        ),
    ]
)
