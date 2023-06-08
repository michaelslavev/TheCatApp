//
//  CatBreedListViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

protocol NavigationRoute: Hashable {
    static func path(from pathComponents: [String]) -> [Self]?
}
