//
//  BreedDetailEndpoint.swift
//  TheCatApp
//
//  Created by Michael Slavev on 09.06.2023.
//

import Foundation

enum BreedDetailEndpoint: Endpoint {
    
    case getBreedDetail(catId: String)
    
    var path: String {
        switch self {
        case .getBreedDetail(catId: let catId):
            return "breeds/\(catId)"
        }
    }
    
    var urlParameters: [String : String] {
        return [:]
    }
}
