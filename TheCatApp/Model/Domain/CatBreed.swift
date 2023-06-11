//
//  CatBreed.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

struct CatBreed: Decodable {
    
    let id: String
    let name: String
    let origin: String
    let country_code: String
    let description: String
    let temperament: String
    let life_span: String
    let weight: Weight
    let child_friendly: Int
    let dog_friendly: Int
    let grooming: Int
    let image: CatImage?
    let wikipedia_url: URL?
    let hypoallergenic: Int
    let intelligence: Int
    let health_issues: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case country_code
        case description
        case temperament
        case life_span
        case weight
        case child_friendly
        case dog_friendly
        case grooming
        case image
        case wikipedia_url
        case hypoallergenic
        case intelligence
        case health_issues
    }
}


// MARK: - Conformances
extension CatBreed: Identifiable {}
extension CatBreed: Equatable {}


// MARK: - Mock
#if DEBUG
extension CatBreed {
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        origin = try container.decode(String.self, forKey: .origin)
        country_code = try container.decode(String.self, forKey: .country_code)
        description = try container.decode(String.self, forKey: .description)
        temperament = try container.decode(String.self, forKey: .temperament)
        life_span = try container.decode(String.self, forKey: .life_span)
        weight = try container.decode(Weight.self, forKey: .weight)
        child_friendly = try container.decode(Int.self, forKey: .child_friendly)
        dog_friendly = try container.decode(Int.self, forKey: .dog_friendly)
        grooming = try container.decode(Int.self, forKey: .grooming)
        
        // Defaults possibly missing cat image to Garfield (mock) to keep UI ok
        if let image = try container.decodeIfPresent(CatImage.self, forKey: .image) {
            self.image = image
        } else {
            self.image = CatImage.mock
        }
        
        wikipedia_url = try container.decodeIfPresent(URL.self, forKey: .wikipedia_url)
        hypoallergenic = try container.decode(Int.self, forKey: .hypoallergenic)
        intelligence = try container.decode(Int.self, forKey: .intelligence)
        health_issues = try container.decode(Int.self, forKey: .health_issues)
    }
    
    
    static let mock: CatBreed = .init(
        id: "abys",
        name: "Abyssinian",
        origin: "Egypt",
        country_code: "EG",
        description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        temperament: "aaaaaaa",
        life_span: "14 - 15",
        weight: .mock,
        child_friendly: 3,
        dog_friendly: 4,
        grooming: 1,
        image: .mock,
        wikipedia_url: URL(string: "https://en.wikipedia.org/wiki/Abyssinian_(cat)")!,
        hypoallergenic: 5,
        intelligence: 3,
        health_issues: 1
    )
    
    static let catBreeds: [CatBreed] = {
        (0 ... 20).map {
            CatBreed(
                id: "abys",
                name: "Abyssinian - \($0)",
                origin: "Egypt",
                country_code: "EG",
                description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                temperament: "aaaaaaa",
                life_span: "14 - 15",
                weight: .mock,
                child_friendly: 3,
                dog_friendly: 4,
                grooming: 1,
                image: .mock,
                wikipedia_url: URL(string: "https://en.wikipedia.org/wiki/Abyssinian_(cat)")!,
                hypoallergenic: 5,
                intelligence: 3,
                health_issues: 1
            )
        }
    }()
}
#endif
