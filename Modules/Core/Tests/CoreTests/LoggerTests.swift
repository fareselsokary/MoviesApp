//
//  LoggerTests.swift
//  Core
//
//  Created by fares on 20/06/2025.
//

@testable import Core
import XCTest

final class LoggerTests: XCTestCase {
    func testLoggingDisabledDoesNotPrint() {
        Logger.isLoggingEnabled = false
        let output = captureOutput {
            Logger.verbose("Test verbose")
            Logger.error("Test error")
        }
        XCTAssertTrue(output.isEmpty, "Output should be empty when logging is disabled")
    }

    func testVerboseLogFormat() {
        Logger.isLoggingEnabled = true
        let output = captureOutput {
            Logger.verbose("This is a verbose message")
        }
        XCTAssertTrue(output.contains("🔵 [Verbose]"), "Should contain verbose log level prefix")
        XCTAssertTrue(output.contains("This is a verbose message"), "Should contain message")
        XCTAssertTrue(output.contains(".swift:"), "Should contain file:line info")
    }

    func testErrorLogFormat() {
        Logger.isLoggingEnabled = true
        let output = captureOutput {
            Logger.error("This is an error message")
        }
        XCTAssertTrue(output.contains("🚨 [Error]"), "Should contain error log level prefix")
        XCTAssertTrue(output.contains("This is an error message"), "Should contain message")
    }

    // MARK: - Helper

    private func captureOutput(_ action: () -> Void) -> String {
        let pipe = Pipe()
        let originalSTDOUT = dup(STDOUT_FILENO)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

        action()

        pipe.fileHandleForWriting.closeFile()
        dup2(originalSTDOUT, STDOUT_FILENO)

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
}
