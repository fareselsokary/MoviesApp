//
//  NetworkConfiguration.swift
//  Networking
//
//  Created by fares on 17/06/2025.
//

import Foundation

/// Manages global networking parameters such as base URLs and API keys.
public final class NetworkConfiguration {
    /// Shared singleton instance, thread-safe and lazily initialized.
    public static let shared = NetworkConfiguration()

    /// The base URL for API requests.
    public var baseURL: String

    /// The API key to be appended to requests.
    public var apiKey: String

    /// Default headers for all network requests.
    public var defaultHeaders: [String: String]?

    /// Private initializer ensures only one instance.
    private init() {
        baseURL = ""
        apiKey = ""
        defaultHeaders = nil
    }
}
