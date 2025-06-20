//
//  MovieDetailViewModel.swift
//  Features
//
//  Created by fares on 18/06/2025.
//

import Combine
import Core
import Domain
import Foundation
import Repository

// MARK: - MovieDetailViewModel

public final class MovieDetailViewModel: ObservableObject {
    // Published properties that the UI will bind to and reactively update.
    @Published var movieDetails: MovieDetailModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // Dependencies and properties
    private let movieId: Int
    private let movieRepository: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    public init(
        movieId: Int,
        movieRepository: MovieRepositoryProtocol = MovieRepository.default
    ) {
        self.movieId = movieId
        self.movieRepository = movieRepository
        loadMovieDetails()
    }

    // MARK: - Fetching movie details

    func loadMovieDetails() {
        // Avoid starting a new request if one is already in progress
        guard !isLoading else { return }
        isLoading = true

        movieRepository.fetchMovieDetails(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false

                // Handle completion errors
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                    Logger.error("Failed to load movie details for ID \(self?.movieId ?? -1): \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] movieDetail in
                // Successfully received movie details
                self?.movieDetails = movieDetail
                self?.isLoading = false
                Logger.verbose("Successfully loaded movie details for ID \(movieDetail.id).")
            }
            .store(in: &cancellables) // Store subscription to keep it alive
    }
}

// MARK: - Computed Properties

extension MovieDetailViewModel {
    var headerImage: String {
        movieDetails?.backdropPath ?? ""
    }

    var posterImage: String {
        movieDetails?.posterPath ?? ""
    }

    var title: String {
        let releaseDate = movieDetails?.releaseDate?.formattedYear() ?? ""
        let title = movieDetails?.title ?? ""
        // Append the year in parentheses if available
        return releaseDate.isEmpty ? title : "\(title) (\(releaseDate))"
    }

    var genres: String {
        movieDetails?.genres.compactMap { $0.name }.joined(separator: ", ") ?? ""
    }

    var overView: String {
        movieDetails?.overview ?? ""
    }

    var homePage: String {
        movieDetails?.homepage ?? ""
    }

    var supportedLanguage: String {
        movieDetails?.spokenLanguages.compactMap { $0.name }.joined(separator: ", ") ?? ""
    }

    var status: String {
        movieDetails?.status ?? ""
    }

    var duration: String {
        movieDetails?.runtime?.formattedHoursAndMinutes ?? ""
    }

    var budget: String {
        movieDetails?.budget?.formattedPrice() ?? ""
    }

    var revenue: String {
        movieDetails?.revenue?.formattedPrice() ?? ""
    }
}
