//
//  String+Helpers.swift
//  Core
//
//  Created by fares on 20/06/2025.
//

import Foundation

public extension String? {
    var isEmptyOrNil: Bool {
        return self?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }

    var isNotEmptyOrNotNil: Bool {
        return !isEmptyOrNil
    }
}

public extension String {
    func trimmingWhiteSpacesAndNewlines() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isBlankString: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
