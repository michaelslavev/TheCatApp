//
//  CatBreedListViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

@MainActor final class CatBreedListViewModel: ObservableObject {
    
    @Injected private var apiManager: APIManaging
    private var currentPage: Int = 0
    
    @Published var breeds: [CatBreed] = []
    @Published var state: State = .initial
    @Published var sortOption: SortOption = .name

    // MARK: - Enum definitions
    enum State {
        case initial
        case loading
        case fetched(loadingMore: Bool)
        case failed
    }
    
    enum SortOption: CaseIterable, Identifiable, CustomStringConvertible {
        case name
        case nameReversed
        case lifeExpectancy
        case lifeExpectancyReversed
        case weight
        case weightReversed
        case hypoalergenicFirst
        
        var id: Self { self }

        var description: String {

            switch self {
            case .name:
                return "Name A-Z"
            case .nameReversed:
                return "Name Z-A"
            case .lifeExpectancy:
                return "Longest living first"
            case .lifeExpectancyReversed:
                return "Shortest living first"
            case .weight:
                return "Heaviest first"
            case .weightReversed:
                return "Lightest first"
            case .hypoalergenicFirst:
                return "Hypoalergenic first"
            }
        }
    }
    
    // MARK: - API call handling
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
            sortCatBreeds(sort: sortOption)
            //breeds = breeds.sorted { $0.name < $1.name }

            
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
    
    // MARK: - support functions
    // sort cat breeds by selected option
    func sortCatBreeds(sort: SortOption) {
        switch sort {
        case .name:
            breeds.sort(by: { $0.name < $1.name })
        case .nameReversed:
            breeds.sort(by: { $0.name > $1.name })
        case .lifeExpectancy:
            breeds.sort(by: { breed1, breed2 in
                let lifeRange1 = breed1.life_span
                let lifeRange2 = breed2.life_span
                
                // Extract the numeric values from the life range strings
                let life1 = extractValues(from: lifeRange1)
                let life2 = extractValues(from: lifeRange2)
                
                // Compare the first life span values
                if life1.firstValue > life2.firstValue {
                    return true
                } else if life1.firstValue < life2.firstValue {
                    return false
                }
                
                // If the first life span values are equal, compare the second
                if life1.secondValue > life2.secondValue {
                    return true
                } else if life1.secondValue < life2.secondValue {
                    return false
                }
                
                // If both life spans values are equal, compare by name
                return breed1.name < breed2.name
            })
        case .lifeExpectancyReversed:
            breeds.sort(by: { breed1, breed2 in
                let lifeRange1 = breed1.life_span
                let lifeRange2 = breed2.life_span
                
                // Extract the numeric values from the life range strings
                let life1 = extractValues(from: lifeRange1)
                let life2 = extractValues(from: lifeRange2)
                
                // Compare the first life span values
                if life1.firstValue < life2.firstValue {
                    return true
                } else if life1.firstValue > life2.firstValue {
                    return false
                }
                
                // If the first life span values are equal, compare the second
                if life1.secondValue < life2.secondValue {
                    return true
                } else if life1.secondValue > life2.secondValue {
                    return false
                }
                
                // If both life spans values are equal, compare by name
                return breed1.name < breed2.name
            })
        case .weight:
            breeds.sort(by: { breed1, breed2 in
                let weightRange1 = breed1.weight.metric
                let weightRange2 = breed2.weight.metric
                
                // Extract the numeric values from the weight range strings
                let weight1 = extractValues(from: weightRange1)
                let weight2 = extractValues(from: weightRange2)
                
                // Compare the first weight values
                if weight1.firstValue > weight2.firstValue {
                    return true
                } else if weight1.firstValue < weight2.firstValue {
                    return false
                }
                
                // If the first weight values are equal, compare the second weight values
                if weight1.secondValue > weight2.secondValue {
                    return true
                } else if weight1.secondValue < weight2.secondValue {
                    return false
                }
                
                // If both weight values are equal, compare by name
                return breed1.name < breed2.name
            })
        case .weightReversed:
            breeds.sort(by: { breed1, breed2 in
                let weightRange1 = breed1.weight.metric
                let weightRange2 = breed2.weight.metric
                
                // Extract the numeric values from the weight range strings
                let weight1 = extractValues(from: weightRange1)
                let weight2 = extractValues(from: weightRange2)
                
                // Compare the first weight values
                if weight1.firstValue < weight2.firstValue {
                    return true
                } else if weight1.firstValue > weight2.firstValue {
                    return false
                }
                
                // If the first weight values are equal, compare the second weight values
                if weight1.secondValue < weight2.secondValue {
                    return true
                } else if weight1.secondValue > weight2.secondValue {
                    return false
                }
                
                // If both weight values are equal, compare by name
                return breed1.name < breed2.name
            })
        case .hypoalergenicFirst:
            // First sort by hypoalergenic then name
            breeds.sort(by: { breed1, breed2 in
                if breed1.hypoallergenic == breed2.hypoallergenic {
                    return breed1.name < breed2.name
                }
                return breed1.hypoallergenic > breed2.hypoallergenic
            })
        }
    }
    
    // compare range values (weight and life expectancy)
    private func extractValues(from range: String) -> (firstValue: Int, secondValue: Int) {
        let components = range.components(separatedBy: "-")
        
        // Extract the numeric values from the weight range strings
        if let firstValue = Int(components.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""),
           let secondValue = Int(components.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") {
            return (firstValue, secondValue)
        }
        
        return (0, 0)
    }
    
}
