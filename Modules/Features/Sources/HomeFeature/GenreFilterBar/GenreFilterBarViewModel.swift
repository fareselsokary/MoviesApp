//
//  GenreFilterBarViewModel.swift
//  Features
//
//  Created by fares on 18/06/2025.
//

import Domain
import Foundation

// MARK: - GenreFilterBarViewModel

class GenreFilterBarViewModel: Identifiable, ObservableObject {
    @Published var genres: [GenreModel]

    init(
        genres: [GenreModel]
    ) {
        self.genres = genres
    }
}

#if DEBUG
    extension GenreFilterBarViewModel {
        static let preview: GenreFilterBarViewModel = .init(
            genres: [
                GenreModel(id: 1, name: "Animation"),
                GenreModel(id: 2, name: "Comedy"),
                GenreModel(id: 3, name: "Adventure"),
                GenreModel(id: 4, name: "Adventure"),
                GenreModel(id: 5, name: "Adventure"),
                GenreModel(id: 6, name: "Adventure")
            ]
        )
    }
#endif
