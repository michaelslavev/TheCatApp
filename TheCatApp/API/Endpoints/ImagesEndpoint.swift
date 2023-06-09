//
//  ImagesEndpoint.swift
//  TheCatApp
//
//  Created by Michael Slavev on 09.06.2023.
//

import Foundation

enum ImagesEndpoint: Endpoint {
    
    case getImages(catId: String)
    
    var path: String {
        switch self {
        case .getImages(catId: let catId):
            return "images/\(catId)"
        }
    }
    
    var urlParameters: [String : String] {
        return [:]
    }
}
