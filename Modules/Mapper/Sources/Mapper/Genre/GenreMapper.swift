//
//  GenreModel.swift
//  Mapper
//
//  Created by fares on 19/06/2025.
//

import API
import Domain
import Persistence

// MARK: - GenreModel → CachedGenreModel

public extension GenreModel {
    /// Converts a `GenreModel` from the domain layer into a `CachedGenreModel`
    /// for local persistence (e.g., saving to a database).
    func toCached() -> CachedGenreModel {
        CachedGenreModel(
            id: id,
            name: name
        )
    }
}

// MARK: - GenreResponse → GenreModel

public extension GenreResponse {
    /// Converts a `GenreResponse` (typically a network DTO) into a `GenreModel`
    /// used within the domain layer.
    func toModel() -> GenreModel {
        GenreModel(
            id: id,
            name: name
        )
    }
}

// MARK: - CachedGenreModel → GenreModel

public extension CachedGenreModel {
    /// Converts a `CachedGenreModel` (locally stored genre) back into a `GenreModel`
    /// for use in the app's domain layer.
    func toModel() -> GenreModel {
        GenreModel(
            id: id,
            name: name
        )
    }
}
