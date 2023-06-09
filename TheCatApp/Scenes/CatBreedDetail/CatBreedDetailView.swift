//
//  CatBreedDetailView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import SwiftUI

struct CatBreedDetailView: View {
    
    @StateObject var viewModel: CatBreedDetailViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()
            
            ScrollView {
                VStack(spacing: 16) {
                    switch viewModel.state {
                    case .initial:
                        ProgressView()
                    case .loading:
                        ProgressView()
                    case .fetched:
                        if let breed = viewModel.breed {
                            makeImage(url: breed.image?.url)
                            makeInfo(breed: breed)
                        }
                        
                    case .failed:
                        Text("Sorry character fetch failed")
                    }
                    
                }
            }
        }
        .navigationTitle(viewModel.breed?.name ?? "")
        .onFirstAppear {
            Task {
                await viewModel.fetch(catId: viewModel.id ?? "beng")
            }
        }
    }
}

private extension CatBreedDetailView {
    func makeImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }
    
    func makeInfo(breed: CatBreed) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    makeInfoRow(title: breed.origin, iconName: "globe")
                    makeInfoRow(title: breed.life_span + " years", iconName: "bolt.heart.fill")
                }
            }
            
            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                makeInfoRow(title: breed.description, iconName: "info.circle")
            }
        }
        .padding(.horizontal, 8)
    }
    
    func makeInfoRow(title: String, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            
            Text(title)
        }
        .font(.appItemDescription)
        .foregroundColor(.appTextBody)
    }
}


struct CatBreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailView(viewModel: CatBreedDetailViewModel(id: "abys"))
    }
}
