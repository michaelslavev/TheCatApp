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
    private var currentPage: Int = 0
    
    @Published var breeds: [CatBreed] = []
    @Published var state: State = .initial
    
    
    func fetchMoreIfNeeded(for breed: CatBreed) async {
        
        guard breed == breeds.last else {
            return
        }
        
        let page = currentPage
        
        state = .fetched(loadingMore: true)
        
        await fetch(page: page)
    }
    
    
    func load() async {
        state = .loading
        await fetch()
    }
    
    
    func fetch(page: Int? = 0) async {
        
        do {
            
            let endpoint = BreedsEndpoint.getBreeds(page: page)
            
            let response: [CatBreed] = try await apiManager.request(endpoint: endpoint)
            
            breeds += response
            
            state = .fetched(loadingMore: false)
            currentPage += 1
        } catch {
            
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                
                state = .fetched(loadingMore: false)
                
                return
            }
            
            debugPrint(error)
            state = .failed
        }
    }
    
}
