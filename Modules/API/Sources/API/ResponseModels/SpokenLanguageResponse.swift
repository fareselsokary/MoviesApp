//
//  SpokenLanguageResponse.swift
//  API
//
//  Created by fares on 18/06/2025.
//

import Foundation

public struct SpokenLanguageResponse: Decodable {
    public let iso6391: String
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
}
