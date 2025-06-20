//
//  MovieAPI.swift
//  API
//
//  Created by fares on 18/06/2025.
//

import Foundation
import Networking

/// Defines specific API endpoints related to movies and their parameters.
public enum MovieAPI: Endpoint {
    case trendingMovies(page: Int)
    case movieDetails(id: Int)

    /// The path component for each movie-related API endpoint.
    public var path: String {
        switch self {
        case .trendingMovies:
            return "discover/movie"
        case let .movieDetails(id):
            return "movie/\(id)"
        }
    }

    public var method: HTTPMethod {
        return .get
    }

    public var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case let .trendingMovies(page):
            params["include_adult"] = false
            params["sort_by"] = "popularity.desc"
            params["page"] = page
            return params
        case .movieDetails:
            return nil
        }
    }

    public var headers: [String: String]? {
        return NetworkConfiguration.shared.defaultHeaders
    }
}
