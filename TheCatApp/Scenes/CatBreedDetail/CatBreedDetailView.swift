//
//  CatBreedDetailView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import SwiftUI
import SafariServices

struct CatBreedDetailView: View {
    
    @State var showSafari = false
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
    
    
    func makeSlideShow(images: [CatImage]) -> some View {
        ImageSlider(images)
            .cornerRadius(16)
    }
    
    func makeInfo(breed: CatBreed) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let images = viewModel.images {
                makeSlideShow(images: images)
            }
            
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
            
            
            Button(action: {
                self.showSafari = true
            }) {
                Text(title)
            }
            .sheet(isPresented: $showSafari) {
                SafariView(url: url)
            }
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

// MARK: - Visual rating from 0 to 5
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

// MARK: - WebView
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}


struct CatBreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailView(breed: CatBreed.mock, viewModel: CatBreedDetailViewModel(id: "abys"))
    }
}
