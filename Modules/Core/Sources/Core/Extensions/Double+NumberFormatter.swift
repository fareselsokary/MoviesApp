//
//  Double+NumberFormatter.swift
//  Core
//
//  Created by fares on 20/06/2025.
//

import Foundation

public extension Double {
    func formattedPrice(
        currency: String = "$",
        style: NumberFormatter.Style = .decimal,
        maximumFractionDigits: Int = 0,
        currencyPrefix: Bool = false
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.maximumFractionDigits = maximumFractionDigits

        let formatted = formatter.string(from: NSNumber(value: self)) ?? "\(self)"

        return currencyPrefix ? "\(currency)\(formatted)" : "\(formatted) \(currency)"
    }
}
