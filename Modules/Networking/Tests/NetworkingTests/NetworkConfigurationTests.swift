//
//  NetworkConfigurationTests.swift
//  Networking
//
//  Created by fares on 20/06/2025.
//

@testable import Networking
import XCTest

// Test class for NetworkConfiguration
final class NetworkConfigurationTests: XCTestCase {
    func testDefaultValues() {
        let config = NetworkConfiguration.shared
        XCTAssertEqual(config.baseURL, "")
        XCTAssertEqual(config.apiKey, "")
        XCTAssertNil(config.defaultHeaders)
    }

    func testSettingValues() {
        let config = NetworkConfiguration.shared
        config.baseURL = "https://api.example.com"
        config.apiKey = "12345"
        config.defaultHeaders = ["Content-Type": "application/json"]
        XCTAssertEqual(config.baseURL, "https://api.example.com")
        XCTAssertEqual(config.apiKey, "12345")
        XCTAssertEqual(config.defaultHeaders?["Content-Type"], "application/json")
    }
}
