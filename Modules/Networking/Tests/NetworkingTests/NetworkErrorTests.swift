//
//  NetworkErrorTests.swift
//  Networking
//
//  Created by fares on 20/06/2025.
//

@testable import Networking
import XCTest

final class NetworkErrorTests: XCTestCase {
    func testEquatableCases() {
        XCTAssertEqual(NetworkError.invalidURL, .invalidURL)
        XCTAssertEqual(NetworkError.noData, .noData)
        XCTAssertEqual(NetworkError.badRequest, .badRequest)

        let err1 = NetworkError.serverError(statusCode: 404, message: "Not Found")
        let err2 = NetworkError.serverError(statusCode: 404, message: "Not Found")
        XCTAssertEqual(err1, err2)

        let decErr1 = NetworkError.decodingError(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "fail"]))
        let decErr2 = NetworkError.decodingError(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "fail"]))
        XCTAssertEqual(decErr1, decErr2)
    }

    func testLocalizedDescriptions() {
        XCTAssertTrue(NetworkError.invalidURL.localizedDescription.contains("invalid"))
        XCTAssertTrue(NetworkError.noData.localizedDescription.contains("No data"))
    }
}
