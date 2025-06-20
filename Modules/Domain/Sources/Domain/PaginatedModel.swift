//
//  PaginatedModel.swift
//  Domain
//
//  Created by fares on 18/06/2025.
//

import Foundation

public struct PaginatedModel<T: Identifiable> {
    /// The current page number of the results.
    public let page: Int
    /// An array of domain models for the current page.
    public let results: [T]
    /// The total number of pages available.
    public let totalPages: Int
    /// The total number of results across all pages.
    public let totalResults: Int

    public init(
        page: Int,
        results: [T],
        totalPages: Int,
        totalResults: Int
    ) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
