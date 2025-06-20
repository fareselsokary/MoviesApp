//
//  CachedSpokenLanguage.swift
//  Persistence
//
//  Created by fares on 19/06/2025.
//

import Foundation
import SwiftData

@Model
public class CachedSpokenLanguage {
    public var iso6391: String?
    public var name: String

    // Many-to-Many relationship back to movies
    @Relationship var movies: [CachedMovieModel] = []

    public init(iso6391: String?, name: String) {
        self.iso6391 = iso6391
        self.name = name
    }
}
