//
//  Logger.swift
//  Core
//
//  Created by fares on 17/06/2025.
//

import Foundation

/// A utility struct for logging messages throughout the application.
public enum Logger {
    /// Logs a message to the console with an optional category.
    /// - Parameters:
    ///   - message: The string message to log.
    ///   - category: An optional string representing the category of the log message (defaults to "App").
    public static func log(_ message: String, category: String = "App") {
        print("[\(category)] \(message)")
    }
}
