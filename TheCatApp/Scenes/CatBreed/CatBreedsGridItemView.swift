//
//  CatBreedsGridItemView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 08.06.2023.
//

import SwiftUI

struct CatBreedsGridItemView: View {
    let breed: CatBreed
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: breed.image?.url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 115, height: 115)
                } placeholder: {
                    ProgressView()
            }
        }
        .cornerRadius(8) // Necessary for working
        .frame(width: 115, height: 115)
    }
}

struct CatBreedsGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsGridItemView(breed: CatBreed.mock)
    }
}
