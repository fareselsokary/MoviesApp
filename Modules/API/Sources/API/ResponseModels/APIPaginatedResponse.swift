//
//  PaginatedResponse.swift
//  API
//
//  Created by fares on 18/06/2025.
//

import Foundation

// MARK: - Shared API Models

/// Represents a paginated response structure from the API.
/// - T: The `Decodable` type of the results within the page.
public struct APIPaginatedResponse<T: Decodable>: Decodable {
    public let page: Int
    public let results: [T]
    public let totalPages: Int
    public let totalResults: Int

    /// Coding keys to map snake_case API response fields to camelCase Swift properties.
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
