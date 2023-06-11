//
//  CatBreedDetailViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import Foundation

@MainActor final class CatBreedDetailViewModel: ObservableObject {
    
    @Injected private var apiManager: APIManaging
    
    var id: String?
    @Published var state: State = .initial
    @Published var breed: CatBreed?
    @Published var images: [CatImage]?
    
    nonisolated init(id: String? = nil) {
        self.id = id
    }
    
    // MARK: - Enum definitions
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    // MARK: - API call handling
    func load(catId: String) async {
        state = .loading
        await fetch(catId: catId)
    }
    
    func fetch(catId: String) async {
        
        do {
            
            let endpoint = BreedDetailEndpoint.getBreedDetail(catId: catId)
            let response: CatBreed = try await apiManager.request(endpoint: endpoint)
            
            let imagesEndpoint = ImagesEndpoint.getImages(catId: catId)
            let imagesResponse: [CatImage] = try await apiManager.request(endpoint: imagesEndpoint)
            
            breed = response
            images = imagesResponse
            
            state = .fetched
        } catch {
            
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                
                state = .fetched
                
                return
            }
            
            debugPrint(error)
            state = .failed
        }
    }
    
}
