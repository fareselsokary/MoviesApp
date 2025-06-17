// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        // Expose individual feature libraries or a single combined library if preferred
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]
        ),
        .library(
            name: "MovieDetailFeature",
            targets: ["MovieDetailFeature"]
        ),
        .library(
            name: "SearchFeature",
            targets: ["SearchFeature"]
        )
        // If you want a single product that encompasses all features:
        // .library(
        //     name: "Features",
        //     targets: ["HomeFeature", "MovieDetailFeature", "SearchFeature"]
        // ),
    ],
    dependencies: [
        .package(path: "../Domain"), // For the models used in ViewModels and Views
        .package(path: "../Data"), // For injecting repositories into ViewModels
        .package(path: "../Core") // For utilities like ImageLoader, Extensions, Logger
    ],
    targets: [
        // Target for the shared ImageLoader within Features (if it's not a separate package)
        .target(
            name: "SharedFeaturesComponents", // A hidden target for shared components within Features
            dependencies: ["Core"],
            path: "Sources/Features" // Point to the root of Features sources
            // Add any common source files directly here if not in sub-folders
            // For now, ImageLoader.swift is in Sources/Features directly
        ),

        .target(
            name: "HomeFeature",
            dependencies: [
                "Domain",
                "Data",
                "Core",
                "SharedFeaturesComponents" // Depend on shared components within Features
                // If MovieDetailFeature can be navigated to from Home, add it here:
                // .product(name: "MovieDetailFeature", package: "Features") // Or just "MovieDetailFeature" if in same package
            ],
            path: "Sources/Features/HomeFeature"
        ),
        .target(
            name: "MovieDetailFeature",
            dependencies: [
                "Domain",
                "Data",
                "Core",
                "SharedFeaturesComponents"
            ],
            path: "Sources/Features/MovieDetailFeature"
        ),
        .target(
            name: "SearchFeature",
            dependencies: [
                "Domain",
                "Data",
                "Core",
                "SharedFeaturesComponents"
                // If MovieDetailFeature can be navigated to from Search, add it here:
                // .product(name: "MovieDetailFeature", package: "Features") // Or just "MovieDetailFeature" if in same package
            ],
            path: "Sources/Features/SearchFeature"
        ),
        // Test targets for each feature
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: ["HomeFeature"],
            path: "Tests/FeaturesTests/HomeFeatureTests"
        ),
        .testTarget(
            name: "MovieDetailFeatureTests",
            dependencies: ["MovieDetailFeature"],
            path: "Tests/FeaturesTests/MovieDetailFeatureTests"
        ),
        .testTarget(
            name: "SearchFeatureTests",
            dependencies: ["SearchFeature"],
            path: "Tests/FeaturesTests/SearchFeatureTests"
        )
    ]
)
