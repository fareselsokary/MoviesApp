//
//  GenresRepository.swift
//  Repository
//
//  Created by fares on 19/06/2025.
//

import API
import Combine
import Core
import Domain
import Foundation
import Networking
import Persistence

// MARK: - GenresRepositoryProtocol

/// A protocol defining the contract for movie-related data operations.
///
public protocol GenresRepositoryProtocol {
    /// Fetches a list of movie genres.
    ///
    /// - Returns: A publisher emitting an array of `GenreModel` representing available genres,
    ///   or a `Network` if the operation fails.
    func fetchMovieGenres() -> AnyPublisher<[GenreModel], Error>
}

// MARK: - GenresRepository

public class GenresRepository: GenresRepositoryProtocol {
    private let apiService: NetworkServiceProtocol
    private let persistenceManager: PersistenceManager<CachedGenreModel>
    private let networkReachability: Networking.NetworkReachability
    private var cancellables = Set<AnyCancellable>()

    /// Initializes the `DefaultMovieRepository` with its dependencies.
    /// - Parameters:
    ///   - apiService: The network service to use for API calls (defaults to `NetworkService`).
    ///   - persistenceManager: The caching manager for local data (defaults to `PersistenceManager.shared`).
    ///   - networkReachability: The service to monitor network connectivity (defaults to `NetworkReachability.shared`).
    public init(
        apiService: NetworkServiceProtocol = NetworkService.default,
        persistenceManager: PersistenceManager<CachedGenreModel>,
        networkReachability: Networking.NetworkReachability = .shared
    ) {
        self.apiService = apiService
        self.persistenceManager = persistenceManager
        self.networkReachability = networkReachability
    }

    /// Fetches a list of movie genres, prioritizing network but falling back to cache on error or offline.
    public func fetchMovieGenres() -> AnyPublisher<[Domain.GenreModel], Error> {
        Logger.verbose("Fetching movie genres...")
        let networkPublisher = apiService.request(API.GenreAPI.listGenres)
            .map { (apiResponse: GenreListResponse) -> [Domain.GenreModel] in
                apiResponse.genres.map { $0.toModel() }
            }
            .map { [weak self] models in
                self?.saveGenres(models)
                return models
            }
            .mapError { $0 }
            .eraseToAnyPublisher()

        let fallbackPublisher = fetchGenreFromCache()

        if networkReachability.isConnected {
            return networkPublisher
                .catch { error -> AnyPublisher<[Domain.GenreModel], Error> in
                    Logger.error(
                        "Network failed with \(error), returning cached genres if available."
                    )
                    return fallbackPublisher
                }
                .eraseToAnyPublisher()
        } else {
            Logger.verbose("Offline: Returning cached genres.")
            return fallbackPublisher
        }
    }
}

extension GenresRepository {
    private func saveGenres(_ genres: [GenreModel]) {
        let cached = genres.map { $0.toCached() }
        persistenceManager.save(cached)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables) // Or fire-and-forget if you don't need to retain it
    }

    private func fetchGenreFromCache() -> AnyPublisher<[Domain.GenreModel], Error> {
        return persistenceManager.fetch()
            .map { $0.results.map { $0.toModel() } }
            .eraseToAnyPublisher()
    }
}

// MARK: - Default instance

public extension GenresRepository {
    static var `default`: GenresRepositoryProtocol = {
        let apiService = NetworkService()
        let context = AppModelContainer.shared.context
        let persistenceManager = PersistenceManager<CachedGenreModel>(context: context)
        return GenresRepository(apiService: apiService, persistenceManager: persistenceManager)
    }()
}
