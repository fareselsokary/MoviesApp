//
//  PersistenceManagerProtocol.swift
//  Persistence
//
//  Created by fares on 18/06/2025.
//

import Combine
import Foundation
import SwiftData

/// A protocol that defines a unified interface for performing persistence operations
/// for a specific `PersistentModel` type. It uses an associated type rather than
/// method-level generics, avoiding type erasure and Swift 6 generic shadowing issues.
public protocol PersistenceManagerProtocol {
    associatedtype Entity: PersistentModel

    /// Saves a single persistent model entity to the cache.
    func save(_ entity: Entity) -> AnyPublisher<Void, Error>

    /// Saves multiple persistent model entities to the cache.
    func save(_ entities: [Entity]) -> AnyPublisher<Void, Error>

    /// Fetches entities of the associated type that match the provided predicate.
    func fetch(
        where predicate: Predicate<Entity>?,
        sortedBy sort: [SortDescriptor<Entity>],
        pageSize: Int?,
        page: Int?
    ) -> AnyPublisher<CachedPaginatedModel<Entity>, Error>

    /// Fetches an entity of the associated type by its persistent identifier.
    func fetch(byID id: Entity.ID) -> AnyPublisher<Entity, Error>

    /// Deletes all entities of the associated type from the cache.
    func deleteAll() -> AnyPublisher<Void, Error>
}
