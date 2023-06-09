//
//  CatBreedDetailView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import SwiftUI

struct CatBreedDetailView: View {
    
    let breed: CatBreed
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
                        if let images = viewModel.images {
                            makeImage(url: images[0].url)
                        }
                        if let breed = viewModel.breed {
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
                    makeInfoRow(title: breed.weight.metric + " kg", iconName: "scalemass")
                    if let url = breed.wikipedia_url {
                        makeClickableInfoRow(title: "Tap here for more info on Wikipedia", iconName: "link", url: url)
                    }
                }
            }
            
            Spacer()
            
            Text("Description")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            VStack(alignment: .leading, spacing: 8) {
                makeInfoRow(title: breed.temperament, iconName: "face.smiling")
                makeInfoRow(title: breed.description, iconName: "info.circle")
            }
            
            Spacer()
            
            Text("Characteristics")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            VStack(alignment: .center, spacing: 8) {
                makeRating(characteristic: "Child friendly", rating: breed.child_friendly)
                makeRating(characteristic: "Dog friendly", rating: breed.dog_friendly)
                makeRating(characteristic: "Grooming", rating: breed.grooming)
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
    
    func makeClickableInfoRow(title: String, iconName: String, url: URL) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            
            Link(title, destination: url)
        }
        .font(.appItemDescription)
        .foregroundColor(.appTextBody)
    }
    
    func makeRating(characteristic: String, rating: Int) -> some View {
        
        return  HStack(alignment: .top, spacing: 8) {
            VStack(spacing: 8) {
                Text(characteristic)
                
                StarRating(rating: Double(rating), maxRating: 5)
            }
            .font(.appItemDescription)
            .foregroundColor(.appTextBody)
        }
        
    }
}

struct StarRating: View {
    struct ClipShape: Shape {
        let width: Double
        
        func path(in rect: CGRect) -> Path {
            Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
        }
    }
    
    var rating: Double
    let maxRating: Int
    
    init(rating: Double, maxRating: Int) {
        self.maxRating = maxRating
        self.rating = rating
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Text(Image(systemName: "star"))
                    .foregroundColor(.pink)
                    .aspectRatio(contentMode: .fill)
            }
        }.overlay(
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(0..<maxRating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.pink)
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(
                    ClipShape(width: (reader.size.width / CGFloat(maxRating)) * CGFloat(rating))
                )
            }
        )
    }
}


struct CatBreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailView(breed: CatBreed.mock, viewModel: CatBreedDetailViewModel(id: "abys"))
    }
}
