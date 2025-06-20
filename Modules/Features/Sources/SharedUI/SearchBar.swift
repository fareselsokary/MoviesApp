//
//  SearchBar.swift
//  Features
//
//  Created by fares on 20/06/2025.
//

import SwiftUI

public struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = ""

    public init(
        text: Binding<String>,
        placeholder: String = ""
    ) {
        _text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.none)
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
