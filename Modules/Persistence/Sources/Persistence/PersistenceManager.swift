//
//  PersistenceManager.swift
//  Persistence
//
//  Created by fares on 18/06/2025.
//

import Combine
import Foundation
import SwiftData

// MARK: - PersistenceManager

/// `PersistenceManager` is a generic class that implements `PersistenceManagerProtocol`.
/// It abstracts the SwiftData persistence layer for a specific `PersistentModel` type.
///
/// This design avoids type erasure by using a class-level generic type and an associated
/// type in the protocol.
///
/// Example usage:
/// ```swift
/// let movieManager = PersistenceManager<MovieEntity>(context: modelContext)
/// movieManager.save(movie)
/// ```
public final class PersistenceManager<T: PersistentModel>: PersistenceManagerProtocol where T: Identifiable, T.ID: Codable & Hashable {
    public typealias Entity = T
    private let context: ModelContext

    /// Initializes the persistence manager with a SwiftData context.
    public init(context: ModelContext) {
        self.context = context
    }

    /// Saves a single entity to the SwiftData context.
    public func save(_ entity: T) -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                self.context.insert(entity)
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    /// Saves multiple entities to the SwiftData context.
    public func save(_ entities: [T]) -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                entities.forEach { self.context.insert($0) }
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    /// Fetches entities of type `T` matching a specific predicate.
    public func fetch(
        where predicate: Predicate<T>? = nil,
        sortedBy sort: [SortDescriptor<T>] = [],
        pageSize: Int? = nil,
        page: Int? = nil
    ) -> AnyPublisher<CachedPaginatedModel<Entity>, Error> {
        Future { promise in
            do {
                let descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)

                let result = try self.fetchModels(descriptor, pageSize: pageSize, page: page)
                promise(.success(result))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    /// Fetches a single entity of type `T` by its primary key (id).
    /// Fails with `.failure` if the entity is not found.
    public func fetch(byID id: T.ID) -> AnyPublisher<T, Error> {
        Future { promise in
            do {
                let descriptor = FetchDescriptor<T>(
                    predicate: #Predicate { $0.id == id }
                )
                let results = try self.context.fetch(descriptor)
                if let entity = results.first {
                    promise(.success(entity))
                } else {
                    promise(.failure(NSError(
                        domain: "PersistenceManager",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "Entity not found."]
                    )))
                }
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    /// Deletes all entities of type `T` from the SwiftData store.
    public func deleteAll() -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                let all = try self.context.fetch(FetchDescriptor<T>())
                all.forEach { self.context.delete($0) }
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension PersistenceManager {
    /// Fetches a paginated or full list of models from the context based on the given `FetchDescriptor`.
    ///
    /// - Parameters:
    ///   - descriptor: The base `FetchDescriptor` used to define the fetch request (e.g., filtering and sorting).
    ///   - pageSize: Optional number of items per page. If `nil`, no pagination is applied (i.e., fetch all).
    ///   - page: Optional page number to fetch. Ignored if `pageSize` is `nil`.
    ///
    /// - Returns: A `CachedPaginatedModel` containing the fetched results and pagination metadata.
    ///
    /// This function ensures accurate pagination by:
    /// - Using a **separate unmodified descriptor** (`countDescriptor`) to calculate the total number of matching results.
    /// - Using a **paginated version** (`paginatedDescriptor`) with `fetchLimit` and `fetchOffset` to retrieve only the requested page.
    private func fetchModels(
        _ descriptor: FetchDescriptor<T>,
        pageSize: Int? = nil,
        page: Int? = nil
    ) throws -> CachedPaginatedModel<Entity> {
        // Clone the descriptor for counting (unmodified so it returns the total number of results).
        let countDescriptor = descriptor

        // Create a separate descriptor to apply pagination limits.
        var paginatedDescriptor = descriptor
        if let page = page, let pageSize = pageSize {
            paginatedDescriptor.fetchLimit = pageSize
            paginatedDescriptor.fetchOffset = page * pageSize
        }

        // Fetch the models for the current page (or full set if no pagination).
        let results = try context.fetch(paginatedDescriptor)

        // Get the total number of matching items (not just in the current page).
        let totalCount = try context.fetchCount(countDescriptor)

        // Determine the effective page size (used for computing total pages).
        let effectivePageSize = pageSize ?? totalCount
        let totalPages = effectivePageSize > 0
            ? (totalCount + effectivePageSize - 1) / effectivePageSize
            : 1

        // Use 0 as the default current page if none was provided.
        let currentPage = page ?? 0

        return CachedPaginatedModel(
            page: currentPage,
            results: results,
            totalPages: totalPages,
            totalResults: totalCount
        )
    }
}
