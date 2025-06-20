// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Routing",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Routing",
            targets: ["Routing"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Routing",
            path: "Sources/Routing"
        ),
        .testTarget(
            name: "RoutingTests",
            dependencies: ["Routing"],
            path: "Tests/RoutingTests"
        )
    ]
)
