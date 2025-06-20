//
//  Array+uniqued.swift
//  Core
//
//  Created by fares on 20/06/2025.
//

import Foundation

public extension Sequence {
    func unique<T: Hashable>(by keySelector: (Element) -> T) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert(keySelector($0)).inserted }
    }
}
