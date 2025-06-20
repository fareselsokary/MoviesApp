//
//  ParameterEncodingTests.swift
//  Networking
//
//  Created by fares on 20/06/2025.
//

@testable import Networking
import XCTest

final class ParameterEncodingTests: XCTestCase {
    func testUrlEncodingAddsQueryItems() throws {
        var request = URLRequest(url: URL(string: "https://example.com")!)
        try ParameterEncoding.urlEncoding.encode(&request, with: ["key": "value"])

        let urlString = request.url?.absoluteString
        XCTAssertTrue(urlString?.contains("key=value") == true)
    }

    func testJsonEncodingSetsBodyAndHeader() throws {
        var request = URLRequest(url: URL(string: "https://example.com")!)
        try ParameterEncoding.jsonEncoding.encode(&request, with: ["key": "value"])

        XCTAssertNotNil(request.httpBody)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")

        let bodyString = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(bodyString?.contains("\"key\":\"value\"") == true)
    }
}
