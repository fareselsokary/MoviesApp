// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Persistence",
            targets: ["Persistence"]
        )
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "Persistence",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Core", package: "Core")
            ],
            path: "Sources/Persistence"
        ),
        .testTarget(
            name: "PersistenceTests",
            dependencies: ["Persistence"],
            path: "Tests/PersistenceTests"
        )
    ]
)
