//
//  DateFormatter.swift
//  Core
//
//  Created by fares on 17/06/2025.
//

import Foundation

public extension DateFormatter {
    /// Custom DateFormatter for parsing "YYYY-MM-DD" date strings from the API.
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
