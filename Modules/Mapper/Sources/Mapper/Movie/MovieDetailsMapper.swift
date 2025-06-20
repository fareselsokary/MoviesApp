//
//  MovieResponseMapper.swift
//  Mapper
//
//  Created by fares on 19/06/2025.
//

import API
import Domain
import Persistence

// MARK: - MovieDetailResponse → MovieDetailModel

public extension MovieDetailResponse {
    /// Converts a `MovieDetailResponse` (network DTO) into a `MovieDetailModel`
    /// for use across the app's domain layer.
    func toModel() -> MovieDetailModel {
        MovieDetailModel(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            genres: genres.map { GenreModel(id: $0.id, name: $0.name) },
            homepage: homepage,
            budget: budget,
            revenue: revenue,
            spokenLanguages: spokenLanguages.map { SpokenLanguage(iso6391: $0.iso6391, name: $0.name) },
            status: status,
            runtime: runtime
        )
    }
}

// MARK: - MovieDetailModel → CachedMovieModel

public extension MovieDetailModel {
    /// Converts a `MovieDetailModel` into a `CachedMovieModel` for local persistence.
    func toCached() -> CachedMovieModel {
        let genres = genres.map { CachedGenreModel(from: $0) }
        return CachedMovieModel(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            overview: overview,
            backdropPath: backdropPath,
            homepage: homepage,
            budget: budget,
            revenue: revenue,
            spokenLanguages: spokenLanguages.map { CachedSpokenLanguage(iso6391: $0.iso6391, name: $0.name) },
            status: status,
            runtime: runtime,
            genres: genres
        )
    }
}

// MARK: - CachedMovieModel → MovieDetailModel

public extension CachedMovieModel {
    /// Converts a `CachedMovieModel` (local data) back into a `MovieDetailModel`.
    /// Falls back to empty strings for optional fields like `overview` and `backdropPath`.
    func toModel() -> MovieDetailModel {
        MovieDetailModel(
            id: id,
            title: title,
            overview: overview ?? "",
            posterPath: posterPath,
            backdropPath: backdropPath ?? "",
            releaseDate: releaseDate,
            genres: genres.map { GenreModel(id: $0.id, name: $0.name) },
            homepage: homepage,
            budget: budget,
            revenue: revenue,
            spokenLanguages: spokenLanguages.map { SpokenLanguage(iso6391: $0.iso6391, name: $0.name) },
            status: status,
            runtime: runtime
        )
    }
}
