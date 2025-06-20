import Combine
@testable import Persistence
import SwiftData
import XCTest

// MARK: - PersistenceManagerTests

final class PersistenceManagerTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var manager: MockPersistenceManager!

    override func setUp() {
        super.setUp()
        manager = MockPersistenceManager()
    }

    func testSaveEntity() {
        let entity = MockEntity(title: "title")
        let exp = expectation(description: "Save single entity")

        manager.save(entity)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error saving entity: \(error)")
                }
                exp.fulfill()
            }, receiveValue: {})
            .store(in: &cancellables)

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(manager.savedEntities.count, 1)
    }

    func testFetchByID() {
        let entity = MockEntity(title: "title")
        _ = manager.save(entity)

        let exp = expectation(description: "Fetch by ID")
        manager.fetch(byID: entity.id)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error fetching entity: \(error)")
                }
                exp.fulfill()
            }, receiveValue: { fetchedEntity in
                XCTAssertEqual(fetchedEntity.id, entity.id)
            })
            .store(in: &cancellables)

        wait(for: [exp], timeout: 1.0)
    }

    func testDeleteAll() {
        let entity = MockEntity(title: "title")
        _ = manager.save(entity)

        let exp = expectation(description: "Delete all")
        manager.deleteAll()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Error deleting all: \(error)")
                }
                exp.fulfill()
            }, receiveValue: {})
            .store(in: &cancellables)

        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(manager.savedEntities.isEmpty)
    }
}

// MARK: - MockEntity

@Model
final class MockEntity: Identifiable {
    var id: UUID
    var title: String

    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}

// MARK: - MockPersistenceManager

// Mock persistence manager
final class MockPersistenceManager: PersistenceManagerProtocol {
    typealias Entity = MockEntity

    var savedEntities = [MockEntity]()

    func save(_ entity: MockEntity) -> AnyPublisher<Void, Error> {
        savedEntities.append(entity)
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func save(_ entities: [MockEntity]) -> AnyPublisher<Void, Error> {
        savedEntities.append(contentsOf: entities)
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func fetch(where predicate: Predicate<MockEntity>?, sortedBy sort: [SortDescriptor<MockEntity>], pageSize: Int?, page: Int?) -> AnyPublisher<CachedPaginatedModel<MockEntity>, Error> {
        let model = CachedPaginatedModel(page: 0, results: savedEntities, totalPages: 1, totalResults: savedEntities.count)
        return Just(model).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func fetch(byID id: MockEntity.ID) -> AnyPublisher<MockEntity, Error> {
        if let found = savedEntities.first(where: { $0.id == id }) {
            return Just(found).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "TestError", code: 404)).eraseToAnyPublisher()
        }
    }

    func deleteAll() -> AnyPublisher<Void, Error> {
        savedEntities.removeAll()
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
