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
        case image
        //case imagesUrl = "images"
        case wikiUrl = "wiki"
    }
    
    let id: String
    let name: String
    let origin: String
    let country_code: String
    let description: String
    let life_span: String
    let weight: Weight
    let child_friendly: Int
    let dog_friendly: Int
    let grooming: Int
    let image: CatImage?
    //let imagesUrl: [URL]
    let wikiUrl: URL?
    
}


// MARK: - Conformances
extension CatBreed: Identifiable {}
extension CatBreed: Equatable {}


// MARK: - Mock
#if DEBUG
extension CatBreed {
    static let mock: CatBreed = .init(
        id: "abys",
        name: "Abyssinian",
        origin: "Egypt",
        country_code: "EG",
        description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        life_span: "14 - 15",
        weight: .mock,
        child_friendly: 3,
        dog_friendly: 4,
        grooming: 1,
        image: .mock,
        wikiUrl: URL(string: "https://en.wikipedia.org/wiki/Abyssinian_(cat)")!
    )
    
    static let catBreeds: [CatBreed] = {
        (0 ... 20).map {
            CatBreed(
                id: "abys",
                name: "Abyssinian - \($0)",
                origin: "Egypt",
                country_code: "EG",
                description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                life_span: "14 - 15",
                weight: .mock,
                child_friendly: 3,
                dog_friendly: 4,
                grooming: 1,
                image: .mock,
                wikiUrl: URL(string: "https://en.wikipedia.org/wiki/Abyssinian_(cat)")!
            )
        }
    }()
}
#endif
