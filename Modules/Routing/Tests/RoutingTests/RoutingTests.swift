import Combine
@testable import Routing
import XCTest

final class RoutingTests: XCTestCase {
    var router: AppRouter!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        router = AppRouter()
    }

    override func tearDown() {
        router = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertNil(router.currentDestination)
        XCTAssertTrue(router.navigationPath.isEmpty)
    }

    func testPushDestination() {
        let destination = NavigationDestination.movieDetail(movieId: 123)
        router.push(destination: destination)
        XCTAssertEqual(router.navigationPath.count, 1)
    }

    func testPopDestination() {
        let destination = NavigationDestination.movieDetail(movieId: 123)
        router.push(destination: destination)
        XCTAssertEqual(router.navigationPath.count, 1)
        router.pop()
        XCTAssertTrue(router.navigationPath.isEmpty)
    }

    func testPopToRoot() {
        let destination1 = NavigationDestination.movieDetail(movieId: 123)
        let destination2 = NavigationDestination.movieDetail(movieId: 456)
        router.push(destination: destination1)
        router.push(destination: destination2)
        XCTAssertEqual(router.navigationPath.count, 2)
        router.popToRoot()
        XCTAssertTrue(router.navigationPath.isEmpty)
    }

    func testSetCurrentDestination() {
        router.currentDestination = .movieDetail(movieId: 789)
        XCTAssertEqual(router.currentDestination, .movieDetail(movieId: 789))
    }
}
