//
//  Date.swift
//  Core
//
//  Created by fares on 17/06/2025.
//
import Foundation

public extension Date {
    func formattedYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
}
