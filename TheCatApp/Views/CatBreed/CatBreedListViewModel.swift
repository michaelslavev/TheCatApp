//
//  CatBreedListViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

@MainActor final class CatBreedListViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case fetched(loadingMore: Bool)
        case failed
    }
    
    @Injected private var apiManager: APIManaging
}
