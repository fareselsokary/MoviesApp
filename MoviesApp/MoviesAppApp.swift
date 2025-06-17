//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by fares on 17/06/2025.
//

import Persistence
import Routing
import SwiftData
import SwiftUI

/// The main entry point of the "Movies" iOS application.
/// Initializes the SwiftData ModelContainer and sets up the root view.
@main
struct MoviesApp: App {
    /// The shared SwiftData ModelContainer for the application.
    /// This manages the persistent storage of CachedMovie and CachedGenre objects.
    let modelContainer: ModelContainer

    /// Initializes the MoviesApp, setting up the SwiftData ModelContainer.
    init() {
        do {
            // Attempt to create the ModelContainer with the defined SwiftData models.
            modelContainer = try ModelContainer(for: CachedMovie.self, CachedGenre.self)
        } catch {
            // Fatal error if the ModelContainer cannot be created, as persistence is crucial.
            fatalError("Failed to create ModelContainer for MoviesApp: \(error.localizedDescription)")
        }
    }

    /// The body of the App, defining the scene and its content.
    var body: some Scene {
        WindowGroup {
            /// The root view of the application, responsible for defining the main UI flow.
            ContentView()
        }
        /// Applies the initialized ModelContainer to the entire view hierarchy,
        /// making it available to all SwiftData-powered views and managers.
        .modelContainer(modelContainer)
    }
}
