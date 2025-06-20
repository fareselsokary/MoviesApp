//
//  MovieMapper.swift
//  Mapper
//
//  Created by fares on 19/06/2025.
//

import API
import Domain
import Persistence

// MARK: - MovieResponse → MovieModel

public extension MovieResponse {
    /// Converts a `MovieResponse` (usually a network DTO) into a `MovieModel`,
    /// which is the clean domain model used across the app.
    func toModel() -> MovieModel {
        MovieModel(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            genreIds: genreIds,
            popularity: popularity
        )
    }
}

// MARK: - MovieModel → CachedMovieModel

public extension MovieModel {
    /// Converts a `MovieModel` into a `CachedMovieModel` so that we can store
    /// the movie's basic info locally (e.g. in a database or persistent store).
    func toCached() -> CachedMovieModel {
        CachedMovieModel(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            popularity: popularity
        )
    }
}

// MARK: - CachedMovieModel → MovieModel

public extension CachedMovieModel {
    /// Converts a `CachedMovieModel` (local cached version) back into a `MovieModel`.
    /// Note: `genres` on the cached model contains full genre objects, so we map
    /// their `id` properties to populate the `genreIds` list expected in `MovieModel`.
    func toModel() -> MovieModel {
        MovieModel(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            genreIds: genres.map { $0.id },
            popularity: popularity ?? 0
        )
    }
}
