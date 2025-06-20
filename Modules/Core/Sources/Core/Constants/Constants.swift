//
//  Constants.swift
//  Core
//
//  Created by fares on 17/06/2025.
//

import Foundation

/// A struct to hold global constants for the application, such as API keys and base URLs.
public struct Constants {
    // MARK: - API Keys & Base URLs

    /// The API key for The Movie Database (TMDb).
    /// IMPORTANT: In a production application, API keys should be handled more securely
    /// (e.g., through environment variables or a build configuration, not hardcoded in source).
    public static let apiKey = ""
    /// The base URL for the TMDb API.
    public static let baseURL = "https://api.themoviedb.org/3"
    /// The base URL for TMDb image assets.
    public static let imageBaseURL = "https://image.tmdb.org/t/p/"

    // MARK: - Image Sizes

    /// Recommended image size for movie posters.
    public static let posterImageSize = "w500" // Example: "w500", "original"
    /// Recommended image size for movie backdrops.
    public static let backdropImageSize = "w1280" // Example: "w1280", "original"

    /// API request page size
    public static let pageSize = 20

    /// Private initializer to prevent external instantiation.
    private init() {}
}
