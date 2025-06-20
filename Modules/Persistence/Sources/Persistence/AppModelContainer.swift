//
//  AppModelContainer.swift
//  Persistence
//
//  Created by fares on 19/06/2025.
//

import SwiftData

public final class AppModelContainer {
    public static let shared = AppModelContainer()

    public let container: ModelContainer

    public lazy var context: ModelContext = {
        ModelContext(container)
    }()

    private init() {
        do {
            container = try ModelContainer(
                for: CachedGenreModel.self,
                CachedMovieModel.self,
                CachedSpokenLanguage.self
            )
        } catch {
            fatalError("ModelContainer init error: \(error)")
        }
    }
}
