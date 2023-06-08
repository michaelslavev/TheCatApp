//
//  Weight.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import Foundation

struct Weight: Decodable {
    let imperial: String
    let metric: String
    
    init(imperial: String, metric: String) {
        self.imperial = imperial
        self.metric = metric
    }
}

// MARK: - Conformances
extension Weight: Equatable {}

// MARK: - Mock
#if DEBUG
extension Weight {
    static let mock: Weight = .init(
        imperial: "7  -  10",
        metric: "3  -  5"
    )
}
#endif
