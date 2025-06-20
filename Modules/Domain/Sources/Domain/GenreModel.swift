//
//  GenreModel.swift
//  Domain
//
//  Created by fares on 18/06/2025.
//

import Foundation

public struct GenreModel: Identifiable, Hashable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
