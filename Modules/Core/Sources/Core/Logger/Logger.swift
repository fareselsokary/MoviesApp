//
//  Logger.swift
//  Core
//
//  Created by fares on 17/06/2025.
//

import Foundation

/// A utility struct for logging messages throughout the application.
public enum Logger {
    public enum LogLevel: String {
        case verbose = "VERBOSE" // Detailed logs for debugging.
        case error = "ERROR" // Critical error messages.
    }

    /// Enable or disable all logging globally.
    /// Default is True
    public static var isLoggingEnabled: Bool = true

    /// Logs a message with specified log level.
    public static func log(
        _ message: String,
        level: LogLevel = .verbose,
        file: String = #file,
        line: Int = #line
    ) {
        guard isLoggingEnabled else { return }
        print("\(logPrefix(for: level, file: file, line: line)) \(message)")
    }

    /// Convenience method for verbose messages.
    public static func verbose(
        _ message: String,
        file: String = #file,
        line: Int = #line
    ) {
        log(message, level: .verbose, file: file, line: line)
    }

    /// Convenience method for error messages.
    public static func error(
        _ message: String,
        file: String = #file,
        line: Int = #line
    ) {
        log(message, level: .error, file: file, line: line)
    }

    // MARK: - Private Helper

    private static func logPrefix(for level: LogLevel, file: String, line: Int) -> String {
        let fileName = (file as NSString).lastPathComponent
        let emoji = level == .error ? "🚨" : "🔵"
        return "\(emoji) [\(level.rawValue.capitalized)] \(fileName):\(line)"
    }
}
