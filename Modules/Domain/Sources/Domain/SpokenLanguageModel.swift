//
//  SpokenLanguageModel.swift
//  Domain
//
//  Created by fares on 18/06/2025.
//

import Foundation

public struct SpokenLanguage {
    public let iso6391: String?
    public let name: String

    public init(iso6391: String?, name: String) {
        self.iso6391 = iso6391
        self.name = name
    }
}
