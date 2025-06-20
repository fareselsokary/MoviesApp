//
//  GenreAPI.swift
//  API
//
//  Created by fares on 18/06/2025.
//

import Foundation
import Networking

/// Defines specific API endpoints related to movie genres.
public enum GenreAPI: Endpoint {
    case listGenres // Endpoint for fetching the list of movie genres.

    /// The path component for the genre API endpoint.
    public var path: String {
        switch self {
        case .listGenres:
            return "genre/movie/list"
        }
    }

    /// The HTTP method for genre API requests (always GET for this endpoint).
    public var method: HTTPMethod {
        return .get
    }

    /// Optional parameters for the genre API endpoint (none for this case).
    public var parameters: [String: Any]? {
        return nil
    }

    public var headers: [String: String]? {
        return NetworkConfiguration.shared.defaultHeaders
    }
}
