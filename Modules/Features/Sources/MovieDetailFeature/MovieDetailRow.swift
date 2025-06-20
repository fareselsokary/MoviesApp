//
//  MovieDetailRow.swift
//  Features
//
//  Created by fares on 20/06/2025.
//

import SwiftUI

// MARK: - MovieDetailRow

/// A helper SwiftUI view for displaying a single detail row (label and value),
/// optionally making the value a tappable link if `redirect` is enabled.
public struct MovieDetailRow: View {
    let label: String
    let value: String?
    let redirect: Bool

    public init(label: String, value: String?, redirect: Bool = false) {
        self.label = label
        self.value = value
        self.redirect = redirect
    }

    public var body: some View {
        if let value = value, !value.isEmpty {
            HStack(spacing: 4) {
                Text("\(label):")
                    .font(.footnote.weight(.bold))
                    .multilineTextAlignment(.leading)

                if redirect,
                   let url = URL(string: value) {
                    Link(destination: url) {
                        Text(value)
                            .lineLimit(1)
                            .underline()
                            .foregroundStyle(.blue)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }

                } else {
                    Text(value)
                        .font(.footnote)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
            }
        } else {
            EmptyView()
        }
    }
}
