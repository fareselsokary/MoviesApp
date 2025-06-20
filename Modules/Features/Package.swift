// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Features",
            targets: ["HomeFeature", "MovieDetailFeature", "SharedUI"]
        ),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]
        ),
        .library(
            name: "MovieDetailFeature",
            targets: ["MovieDetailFeature"]
        ),
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.3.2"),
        .package(path: "../Domain"),
        .package(path: "../Repository"),
        .package(path: "../Core"),
        .package(path: "../Routing")
    ],
    targets: [
        .target(
            name: "SharedUI",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "Sources/SharedUI"
        ),
        // HomeFeature target
        .target(
            name: "HomeFeature",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Repository", package: "Repository"),
                .product(name: "Core", package: "Core"),
                .product(name: "Routing", package: "Routing"),
                .target(name: "SharedUI")
            ],
            path: "Sources/HomeFeature"
        ),
        // MovieDetailFeature target
        .target(
            name: "MovieDetailFeature",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Repository", package: "Repository"),
                .product(name: "Core", package: "Core"),
                .target(name: "SharedUI")
            ],
            path: "Sources/MovieDetailFeature"
        ),
        // Test targets for each feature
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: ["HomeFeature"],
            path: "Tests/HomeFeatureTests"
        ),
        .testTarget(
            name: "MovieDetailFeatureTests",
            dependencies: ["MovieDetailFeature"],
            path: "Tests/MovieDetailFeatureTests"
        )
    ]
)
