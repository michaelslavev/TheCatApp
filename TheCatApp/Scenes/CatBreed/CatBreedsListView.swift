//
//  CatBreedListViewModel.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import SwiftUI

struct CatBreedsListView: View {
    
    @StateObject var viewModel = CatBreedListViewModel()
    @State private var displayMode: DisplayMode = .list
    
    let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    // MARK: - Building view
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            ScrollView {
                switch viewModel.state {
                case .initial, .loading:
                    ProgressView()
                case .fetched(let loadingMore):
                    switch displayMode {
                    case .list:
                        makeList()
                    case .grid:
                        makeGrid()
                    }
                    
                    if loadingMore {
                        ProgressView()
                    }
                case .failed:
                    Text("Something went wrong 😕")
                }
            }
        }
        .navigationTitle("Cat Breeds")
        .toolbar {
            // Display mode toggle
            ToolbarItem {
                Button {
                    toggleDisplayMode()
                } label: {
                    displayMode.image
                }
            }
            
            // Sorting options
            ToolbarItem {
                Menu {
                    makeSortOptionButtons()
                } label: {
                    Label("Sort", systemImage: "slider.horizontal.3")
                } .menuOrder(.fixed)
            }
        }.onFirstAppear {
            Task {
                await viewModel.load()
            }
        }
    }
    
    // MARK: - Functions
    func toggleDisplayMode() {
        withAnimation {
            displayMode.toggle()
        }
    }
    
    func makeList() -> some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.breeds) { breed in
                NavigationLink(destination: CatBreedDetailView(
                    breed: breed, viewModel: CatBreedDetailViewModel(id: breed.id))) {
                    CatBreedsListItemView(breed: breed)
                }
                .task {
                    await viewModel.fetchMoreIfNeeded(for: breed)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    func makeGrid() -> some View {
        LazyVGrid(columns: gridItems, spacing: 10) {
            ForEach(viewModel.breeds) { breed in
                NavigationLink(destination: CatBreedDetailView(breed: breed, viewModel: CatBreedDetailViewModel(id: breed.id))) {
                    CatBreedsGridItemView(breed: breed)
                }
                .task {
                    await viewModel.fetchMoreIfNeeded(for: breed)
                }
            }
        }
        .padding(.horizontal, 10)
    }
    
    // Fill menu with sort option buttons
    func makeSortOptionButtons() -> some View {
        ForEach(CatBreedListViewModel.SortOption.allCases) { option in
            Button(action: {
                viewModel.sortOption = option
                viewModel.sortCatBreeds(sort: option)
            }) {
                HStack {
                    if viewModel.sortOption == option {
                        Image(systemName: "checkmark")
                    }
                    Text(String(describing: option))
                }
            }
        }
    }
}

// MARK: - View extension
extension CatBreedsListView {
    enum DisplayMode {
        case list
        case grid
        
        var image: Image {
            switch self {
            case .list:
                return Image(systemName: "square.grid.3x3")

            case .grid:
                return Image(systemName: "list.dash")
            }
        }
        
        mutating func toggle() {
            switch self {
            case .list:
                self = .grid
            case .grid:
                self = .list
            }
        }
    }
}


struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsListView()
    }
}
