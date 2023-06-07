//
//  CatBreed.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

struct CatBreed: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case country_code
        case description
        case life_span
        case weight
        case child_friendly
        case dog_friendly
        case grooming
        case imageUrl = "image"
        case imagesUrl = "images"
        case wikiUrl = "wiki"
    }
    
    let id: String
    let name: String
    let origin: String
    let country_code: String
    let description: String
    let life_span: String
    let weight: String
    let child_friendly: Int
    let dog_friendly: Int
    let grooming: Int
    let imageUrl: URL
    let imagesUrl: [URL]
    let wikiUrl: URL
    
}

extension CatBreed: Identifiable {}
extension CatBreed: Equatable {}
