//
//  PaginatedResponse.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

struct PaginatedResponse<T: Decodable> {
    let info: PaginationInfo
    let results: [T]
}

extension PaginatedResponse: Decodable {}
