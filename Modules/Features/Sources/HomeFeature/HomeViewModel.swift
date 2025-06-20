//
//  HomeViewModel.swift
//  Features
//
//  Created by fares on 18/06/2025.
//

import Combine
import Core
import Domain
import Foundation
import Repository

// MARK: - HomeViewModel

/// The ViewModel for the Home screen, managing trending movies, genre filtering, and navigation logic.
/// It coordinates between the movie repository and genre repository, and handles UI-binding states.
class HomeViewModel: ObservableObject {
    // MARK: - Published UI Bindings

    /// The list of movies filtered based on genre and search text.
    @Published var filteredMovies: [MovieModel] = []

    /// The list of available movie genres.
    @Published var genres: [GenreModel] = []

    /// An error message to show to the user, if any.
    @Published var errorMessage: String?

    /// The ID of the currently selected genre, if any.
    @Published var selectedGenreId: Int?

    /// The search text entered by the user.
    @Published var searchText: String = ""

    /// All movies fetched from the backend (used before filtering).
    @Published private var movies: [MovieModel] = []

    // MARK: - Pagination and State

    /// The current page of trending movies being fetched.
    private var currentPage = 1

    /// The total number of available pages from the backend.
    private var totalPages = 1

    ///
    private var pageSize = Constants.pageSize

    /// Indicates whether more movies are currently being loaded.
    private var isLoadingMore: Bool = false

    /// Indicates whether a refresh action is being performed.
    private var isRefreshing: Bool = false

    // MARK: - Dependencies

    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenresRepositoryProtocol

    // MARK: - Combine Cancellables

    private var cancellables = Set<AnyCancellable>()
    private var genreFetchCancellable: AnyCancellable?
    private var moviesFetchCancellable: AnyCancellable?

    // MARK: - Init

    /// Initializes the view model with default or injected repositories.
    init(
        movieRepository: MovieRepositoryProtocol = MovieRepository.default,
        genreRepository: GenresRepositoryProtocol = GenresRepository.default
    ) {
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        bindFilters()
        loadGenres()
        loadMoreMovies()
    }

    // MARK: - Public Actions

    /// Refreshes the movie list and resets pagination and filters.
    func refresh() {
        currentPage = 1
        totalPages = 1
        isLoadingMore = false
        isRefreshing = true
        selectedGenreId = nil
        movies = []
        loadMoreMovies()
    }

    /// Loads more trending movies for the current page and appends them to the list.
    func loadMoreMovies() {
        guard !isLoadingMore else { return }
        isLoadingMore = true

        moviesFetchCancellable?.cancel()
        moviesFetchCancellable = movieRepository
            .fetchTrendingMovies(pageSize: pageSize, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }

                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }

                self.isLoadingMore = false
                self.isRefreshing = false
            } receiveValue: { [weak self] response in
                guard let self else { return }

                if self.isRefreshing {
                    self.movies = response.results
                } else {
                    self.movies += response.results
                }

                self.currentPage += 1
                self.totalPages = response.totalPages
                self.isLoadingMore = false
                self.isRefreshing = false
            }
    }

    /// Loads the list of genres used for filtering.
    func loadGenres() {
        genreFetchCancellable?.cancel()
        genreFetchCancellable = genreRepository
            .fetchMovieGenres()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.genres = response
            }
    }

    /// Applies a search filter to the movie list.
    /// - Parameter query: The search query string entered by the user.
    func applySearchFilter(query: String) {
        searchText = query
    }

    // MARK: - Private Helpers

    /// Binds the movie list to filters for genre and search text.
    private func bindFilters() {
        Publishers.CombineLatest3(
            $movies,
            $searchText.removeDuplicates(),
            $selectedGenreId.removeDuplicates()
        )
        .map { movies, searchText, genreID in
            var filtered = movies

            if !searchText.isBlankString {
                filtered = filtered.filter {
                    $0.title.localizedCaseInsensitiveContains(searchText)
                }
            }

            if let genreID {
                filtered = filtered.filter {
                    $0.genreIds.contains(genreID)
                }
            }
            return filtered.unique(by: { $0.id }) // because api some times return duplicated movies
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &$filteredMovies)
    }
}

// MARK: - Computed UI State

extension HomeViewModel {
    /// The appropriate empty state message to show based on user input and loading status.
    var message: String {
        if !searchText.isBlankString {
            return "No movies found matching \"\(searchText)\""
        } else if isLoadingMore || isRefreshing {
            return ""
        } else {
            return "No movies found"
        }
    }

    /// Whether the initial loading spinner should be shown.
    var isLoading: Bool {
        guard currentPage == 1 else { return false }
        return isLoadingMore || isRefreshing
    }
}
