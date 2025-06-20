//
//  MovieDetailModel.swift
//  Domain
//
//  Created by fares on 18/06/2025.
//


import Foundation

public struct MovieDetailModel: Identifiable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String
    public let backdropPath: String
    public let releaseDate: Date?
    public let genres: [GenreModel]
    public let homepage: String?
    public let budget: Double?
    public let revenue: Double?
    public let spokenLanguages: [SpokenLanguage]
    public let status: String?
    public let runtime: Double?

    public init(
        id: Int,
        title: String,
        overview: String,
        posterPath: String,
        backdropPath: String,
        releaseDate: Date?,
        genres: [GenreModel],
        homepage: String?,
        budget: Double?,
        revenue: Double?,
        spokenLanguages: [SpokenLanguage],
        status: String?,
        runtime: Double?
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.genres = genres
        self.homepage = homepage
        self.budget = budget
        self.revenue = revenue
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.runtime = runtime
    }
}
