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
            ZStack {
                AsyncImage(
                    url: breed.image?.url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                    } placeholder: {
                        ProgressView()
                }
            }
            .cornerRadius(8) // Necessary for working
            .frame(width: 110, height: 110)
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(breed.name)
                    .font(.appItemLargeTitle)
                    .foregroundColor(.appTextItemTitle)
                    .multilineTextAlignment(.leading)
                
                
                makeInfoRow(title: breed.origin, iconName: "globe")
                makeInfoRow(title: breed.life_span + " years", iconName: "bolt.heart.fill")
                makeInfoRow(title: breed.weight.metric + " kg", iconName: "scalemass")
                
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
