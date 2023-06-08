//
//  SwiftUIView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import SwiftUI

struct CatBreedsListItemView: View {
    let breed: CatBreed
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(
                url: breed.image?.url) { image in
                    image
                        .resizable()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(breed.name)
                    .font(.appItemLargeTitle)
                    .foregroundColor(.appTextItemTitle)
                    .multilineTextAlignment(.leading)
                
                
                makeInfoRow(title: breed.origin, iconName: "globe")
                makeInfoRow(title: breed.life_span + " years", iconName: "bolt.heart.fill")
                
            }
            .padding(.vertical, 16)
        }
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

struct CatBreedsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsListItemView(breed: CatBreed.mock)
    }
}