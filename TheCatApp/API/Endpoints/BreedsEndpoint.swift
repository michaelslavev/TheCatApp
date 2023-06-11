//
//  BreedsEndpoint.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

enum BreedsEndpoint: Endpoint {
    
    case getBreeds(page: Int?)
    
    var path: String {
        switch self {
        case .getBreeds:
            return "breeds"
        }
    }
    
    var urlParameters: [String : String] {
        switch self {
        case .getBreeds(let page?):
            return [
                "limit": "10",
                "page": String(page)
                ]
        case .getBreeds:
            return [:]
            
        }
        
    }
}
