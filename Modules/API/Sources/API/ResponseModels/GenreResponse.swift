//
//  GenreResponse.swift
//  API
//
//  Created by fares on 18/06/2025.
//

import Core
import Foundation

// MARK: - GenreListResponse

public struct GenreListResponse: Decodable {
    public let genres: [GenreResponse]

    public init(genres: [GenreResponse]) {
        self.genres = genres
    }

    enum CodingKeys: CodingKey {
        case genres
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decode([GenreResponse].self, forKey: .genres)
    }
}

// MARK: - GenreResponse

public struct GenreResponse: Decodable, Identifiable, Hashable {
    public let id: Int
    public let name: String

    enum CodingKeys: CodingKey {
        case id
        case name
    }

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
