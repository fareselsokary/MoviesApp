//
//  CachedMovieModel.swift
//  Persistence
//
//  Created by fares on 18/06/2025.
//

import Domain
import Foundation
import SwiftData

@Model
public final class CachedMovieModel {
    @Attribute(.unique) public var id: Int
    public var title: String
    public var posterPath: String
    public var releaseDate: Date?
    public var overview: String?
    public var backdropPath: String?
    public var homepage: String?
    public var budget: Double?
    public var revenue: Double?
    public var status: String?
    public var runtime: Double?
    public var popularity: Double?

    // Many-to-Many relationship with inverse relationship
    @Relationship(inverse: \CachedGenreModel.movies)
    public var genres: [CachedGenreModel]

    @Relationship(inverse: \CachedSpokenLanguage.movies)
    public var spokenLanguages: [CachedSpokenLanguage]

    public init(
        id: Int,
        title: String,
        posterPath: String,
        releaseDate: Date? = nil,
        overview: String? = nil,
        backdropPath: String? = nil,
        homepage: String? = nil,
        budget: Double? = nil,
        revenue: Double? = nil,
        spokenLanguages: [CachedSpokenLanguage] = [],
        status: String? = nil,
        runtime: Double? = nil,
        popularity: Double? = nil,
        genres: [CachedGenreModel] = []
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.overview = overview
        self.backdropPath = backdropPath
        self.homepage = homepage
        self.budget = budget
        self.revenue = revenue
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.runtime = runtime
        self.popularity = popularity
        self.genres = genres
    }
}
