//
//  DefaultMovieRepository.swift
//  Repository
//
//  Created by fares on 18/06/2025.
//

import API
import Combine
import Core
import Domain
import Foundation
import Mapper
import Networking
import Persistence

// MARK: - MovieRepositoryProtocol

public protocol MovieRepositoryProtocol {
    func fetchTrendingMovies(pageSize: Int, page: Int) -> AnyPublisher<PaginatedModel<MovieModel>, Error>
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetailModel, Error>
}

// MARK: - MovieRepository

public class MovieRepository: MovieRepositoryProtocol {
    private let apiService: NetworkServiceProtocol
    private let persistenceManager: PersistenceManager<CachedMovieModel>
    private let networkReachability: NetworkReachability
    private var cancellables = Set<AnyCancellable>()

    public init(
        apiService: NetworkServiceProtocol,
        persistenceManager: PersistenceManager<CachedMovieModel>,
        networkReachability: NetworkReachability = .shared
    ) {
        self.apiService = apiService
        self.persistenceManager = persistenceManager
        self.networkReachability = networkReachability
    }

    public func fetchTrendingMovies(pageSize: Int, page: Int) -> AnyPublisher<PaginatedModel<MovieModel>, Error> {
        if networkReachability.isConnected {
            Logger.verbose("Fetching trending movies from network.")
            return apiService.request(MovieAPI.trendingMovies(page: page))
                .map { (apiPage: APIPaginatedResponse<MovieResponse>) in
                    PaginatedModel(
                        page: apiPage.page,
                        results: apiPage.results.map { $0.toModel() },
                        totalPages: apiPage.totalPages,
                        totalResults: apiPage.totalResults
                    )
                }
                .map { [weak self] models in
                    self?.saveTrendingMovies(models.results)
                    return models
                }
                .mapError { $0 }
                .eraseToAnyPublisher()
        } else {
            Logger.verbose("Offline: Fetching trending movies from cache.")
            return persistenceManager.fetch(
                sortedBy: [SortDescriptor(\CachedMovieModel.popularity, order: .reverse)],
                pageSize: pageSize,
                page: page
            )
            .map { cached in
                PaginatedModel(
                    page: cached.page,
                    results: cached.results.map { $0.toModel() },
                    totalPages: cached.totalPages,
                    totalResults: cached.totalResults
                )
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
        }
    }

    public func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetailModel, Error> {
        Logger.verbose("Fetching movie details.")

        let networkPublisher = apiService.request(API.MovieAPI.movieDetails(id: id))
            .map { (response: MovieDetailResponse) in response.toModel() }
            .map { [weak self] movie -> MovieDetailModel in
                self?.saveMovieDetails(movie)
                return movie
            }
            .mapError { $0 }
            .eraseToAnyPublisher()

        let fallbackPublisher = fetchMovieDetailsFromCache(id: id)

        if networkReachability.isConnected {
            return networkPublisher
                .catch { error -> AnyPublisher<MovieDetailModel, Error> in
                    Logger.error("Network request failed. Returning cached movie details if available. Error: \(error)")
                    return fallbackPublisher
                }
                .eraseToAnyPublisher()
        } else {
            Logger.error("No internet connection. Returning cached movie details.")
            return fallbackPublisher
        }
    }
}

extension MovieRepository {
    private func saveTrendingMovies(_ movies: [MovieModel]) {
        let cached = movies.map { $0.toCached() }
        persistenceManager.save(cached)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
    }

    private func saveMovieDetails(_ movie: MovieDetailModel) {
        persistenceManager.save(movie.toCached())
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
    }

    private func fetchMovieDetailsFromCache(id: Int) -> AnyPublisher<MovieDetailModel, Error> {
        return persistenceManager.fetch(byID: id)
            .map { $0.toModel() as MovieDetailModel }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

// MARK: - Default instance

public extension MovieRepository {
    static var `default`: MovieRepositoryProtocol = {
        let apiService = NetworkService.default
        let context = AppModelContainer.shared.context
        let persistenceManager = PersistenceManager<CachedMovieModel>(context: context)
        return MovieRepository(apiService: apiService, persistenceManager: persistenceManager)
    }()
}
