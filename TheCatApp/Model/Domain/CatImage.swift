//
//  Image.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import Foundation

struct CatImage: Decodable {
    let id: String
    let url: URL
    
    init(id: String, url: URL) {
        self.id = id
        self.url = url
    }
}

// MARK: - Conformances
extension CatImage: Equatable {}

// MARK: - Mock
#if DEBUG
extension CatImage {
    static let mock: CatImage = .init(
        id: "0XYvRd7oD",
        url: URL(string: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")!
    )
}
#endif
