//
//  CatBreedListViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

enum TabRoute: NavigationRoute {
    case breedDetail(ProvidedData<CatBreed>)
    
    
    static func path(from pathComponents: [String]) -> [TabRoute]? {
        var path = [TabRoute]()
        var components = pathComponents.dropFirst()
        
        while let first = components.first {
            components = components.dropFirst()
            
            if
                let idString = components.first,
                let id = Int(idString)
            {
                switch first {
                case "breed":
                    path.append(.breedDetail(.id(String(id))))
                default:
                    return nil
                }
            }
            
            components = components.dropFirst()
        }
        
        return path
    }
    
    var pathComponents: [String] {
        switch self {
        case let .breedDetail(providedData):
            return ["breed", "\(providedData.id)"]
        }
    }
}
