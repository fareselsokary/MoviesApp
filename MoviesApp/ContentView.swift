//
//  ContentView.swift
//  MoviesApp
//
//  Created by fares on 17/06/2025.
//

import HomeFeature
import MovieDetailFeature
import Routing
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        NavigationStack(path: $appRouter.navigationPath) {
            HomeView()
                .navigationDestination(for: Routing.NavigationDestination.self) { destination in
                    switch destination {
                    case let .movieDetail(movieId):
                        MovieDetailView(viewModel: MovieDetailViewModel(movieId: movieId))
                    }
                }
        }
    }
}
