//
//  BreedsEndpoint.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

enum BreedEndpoint: Endpoint {
    
    case getBreeds(page: Int?)
    
    var path: String {
        switch self {
        case .getBreeds:
            return "breed"
        }
    }
    
    var urlParameters: [String : String] {
        switch self {
        case .getBreeds(let page?):
            return ["page": String(page)]
        case .getBreeds:
            return [:]
        }
        
    }
}
