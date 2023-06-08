//
//  CatBreedDetailViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import Foundation

@MainActor final class CatBreedDetailViewModel: ObservableObject {
    
    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    var id: String?
    @Published var state: State = .initial
    @Published var breed: CatBreed?
    
    nonisolated init(id: String? = nil) {
        self.id = id
    }
    
    func fetch() async {
        state = .loading
     
        try! await Task.sleep(for: .seconds(2))
        
        state = .fetched
        breed = CatBreed.mock
    }
    
}
