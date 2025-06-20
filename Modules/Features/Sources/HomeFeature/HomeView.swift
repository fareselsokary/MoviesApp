//
//  HomeView.swift
//  Features
//
//  Created by fares on 18/06/2025.
//

import Routing
import SharedUI
import SwiftUI

// MARK: - HomeView

/// The main view for the Home feature, displaying trending movies and genre filters.
public struct HomeView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject private var viewModel: HomeViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel())
    }

    public var body: some View {
        VStack(spacing: Style.verticalSpacing) {
            SearchBar(text: $viewModel.searchText, placeholder: "Search TMDP")
                .padding(.horizontal, Style.horizontalPadding)

            GenreFilterBarView(
                viewModel: GenreFilterBarViewModel(genres: viewModel.genres),
                selectedGenreId: $viewModel.selectedGenreId
            )

            VGridView(
                columns: Style.gridColumns,
                columnsSpacing: Style.gridSpacing,
                rowSpacing: Style.gridSpacing,
                items: viewModel.filteredMovies
            ) { movie, index in
                MoviePosterView(
                    viewModel: MoviePosterViewModel(
                        id: movie.id,
                        imageURL: movie.posterPath,
                        title: movie.title,
                        releaseData: movie.releaseDate
                    )
                )
                .onTapGesture {
                    appRouter.push(destination: .movieDetail(movieId: movie.id))
                }
                .onAppear {
                    if viewModel.filteredMovies.last?.id == movie.id {
                        viewModel.loadMoreMovies()
                    }
                }
            } emptyView: {
                Text(viewModel.message)
                    .frame(height: Style.emptyHeight)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, Style.horizontalPadding)
        }
        .loading(isLoading: viewModel.isLoading, message: "Loading Movies...")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Watch New Movies")
                    .font(.title.bold())
                    .foregroundColor(.orange)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            viewModel.refresh()
        }
    }
}

// MARK: HomeView.Style

private extension HomeView {
    enum Style {
        static let verticalSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 8
        static let gridColumns: Int = 2
        static let gridSpacing: CGFloat = 8
        static let emptyHeight: CGFloat = 300
    }
}
