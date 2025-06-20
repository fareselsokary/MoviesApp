//
//  MovieModel.swift
//  Domain
//
//  Created by fares on 18/06/2025.
//

import Foundation

public struct MovieModel: Identifiable, Hashable {
    public let id: Int
    public let title: String
    public let posterPath: String
    public let releaseDate: Date?
    public let genreIds: [Int]
    public let popularity: Double

    public init(
        id: Int,
        title: String,
        posterPath: String,
        releaseDate: Date?,
        genreIds: [Int],
        popularity: Double
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.popularity = popularity
    }
}
