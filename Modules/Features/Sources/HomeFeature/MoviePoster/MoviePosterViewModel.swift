//
//  MoviePosterViewModel.swift
//  Features
//
//  Created by fares on 18/06/2025.
//

import Core
import Foundation

struct MoviePosterViewModel {
    let id: Int
    let imageURL: String?
    let title: String
    let releaseData: String?

    init(
        id: Int,
        imageURL: String?,
        title: String,
        releaseData: Date?
    ) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
        if let releaseData {
            self.releaseData = DateFormatter.yyyyMMdd.string(from: releaseData)
        } else {
            self.releaseData = nil
        }
    }
}
