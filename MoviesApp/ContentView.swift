//
//  ContentView.swift
//  MoviesApp
//
//  Created by fares on 17/06/2025.
//

import HomeFeature
import Routing // Import the Routing module to use AppRouter
import SearchFeature
import SwiftUI

/// The root view of the application, responsible for setting up the main tab-based navigation
/// and managing the top-level routing for presenting sheets/full-screen modals.
struct ContentView: View {
    /// The application's main router, responsible for controlling top-level navigation states.
    /// It is an `ObservableObject` and its changes drive UI presentations (e.g., sheets).
    @StateObject private var appRouter = AppRouter()

    var body: some View {
        TabView {
            /// The Home feature, embedded within a `NavigationView` for hierarchical navigation.
            /// The `appRouter` is injected into its environment for navigation capabilities.
            NavigationView {
                HomeView()
                    .environmentObject(appRouter) // Make the router available to HomeView and its children
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0) // Assign a tag for TabView selection

            /// The Search feature, embedded within a `NavigationView` for hierarchical navigation.
            /// The `appRouter` is injected into its environment for navigation capabilities.
            NavigationView {
                SearchView()
                    .environmentObject(appRouter) // Make the router available to SearchView and its children
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            .tag(1) // Assign a tag for TabView selection
        }
        /// Presents `MovieDetailView` as a sheet when `appRouter.selectedMovieId` is set.
        /// This centralizes modal presentations at the application's root.
        .sheet(item: $appRouter.selectedMovieId) { movieId in
            MovieDetailView(movieId: movieId)
        }
    }
}
