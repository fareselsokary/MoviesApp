//
//  CachedGenreModel.swift
//  Persistence
//
//  Created by fares on 18/06/2025.
//

import Domain
import Foundation
import SwiftData

@Model
public final class CachedGenreModel {
    @Attribute(.unique) public var id: Int
    public var name: String

    // Many-to-Many relationship back to movies
    @Relationship var movies: [CachedMovieModel] = []

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    public convenience init(from domainModel: GenreModel) {
        self.init(id: domainModel.id, name: domainModel.name)
    }
}
