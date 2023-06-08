//
//  CatBreedListViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import SwiftUI

// This object holds the navigation state of the whole App.
class NavigationRouter: ObservableObject {
    @Published var selectedTab: Tab
    @Published var breedsPath: [TabRoute]
    @Published var imagesPath: [TabRoute]
    @Published var votesPath: [TabRoute]
    @Published var likesPath: [TabRoute]
    
    private var selectedPath: [TabRoute] {
        switch selectedTab {
        case .breeds: return breedsPath
        case .images: return imagesPath
        case .votes: return votesPath
        case .likes: return likesPath
        }
    }
    
    init(
        selectedTab: Tab = .breeds,
        breedsPath: [TabRoute] = [],
        imagesPath: [TabRoute] = [],
        votesPath: [TabRoute] = [],
        likesPath: [TabRoute] = []
    ) {
        self.selectedTab = selectedTab
        self.breedsPath = breedsPath
        self.imagesPath = imagesPath
        self.votesPath = votesPath
        self.likesPath = likesPath
    }
}

// MARK: - Public
extension NavigationRouter {
    // Constructs a deeplink URL from the whole NavigationStack of the currently selected tab.
    var deeplinkURL: URL? {
        let pathString = selectedPath
            .flatMap { $0.pathComponents }
            .reduce("") { $0 + "/" + $1 }
        
        return URL.makeShareUrl(for: "\(selectedTab.rawValue)\(pathString)")
    }
    
    // Valid deeplink URL example: rickandmorty://strv.rickandmorty.com/characters/character/1/episode/1/location/1
    func executeDeepLink(url: URL) throws {
        let pathComponents = Array(url.pathComponents.drop { $0 == "/"})
        
        guard
            let tab = Tab(rawValue: pathComponents.first ?? ""),
            let path = TabRoute.path(from: pathComponents)
        else {
            throw DeepLinkError.invalidURL
        }
        
        selectedTab = tab
        
        switch tab {
        case .breeds:
            breedsPath = path
        case .images:
            imagesPath = path
        case .votes:
            votesPath = path
        case .likes:
            likesPath = path
        }
    }
}
