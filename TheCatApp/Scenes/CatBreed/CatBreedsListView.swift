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
    
    func makeList() -> some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.breeds) { breed in
                NavigationLink(destination: CatBreedDetailView(breed: breed, viewModel: CatBreedDetailViewModel(id: breed.id))) {
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
            ToolbarItem {
                Button {
                    toggleDisplayMode()
                } label: {
                    displayMode.image
                }
            }
        }.onFirstAppear {
            Task {
                await viewModel.load()
            }
        }
    }
    
    func toggleDisplayMode() {
        withAnimation {
            displayMode.toggle()
        }
    }
}


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
