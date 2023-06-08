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
        AsyncImage(
            url: breed.image?.url) { image in
                image
                    .resizable()
                    //.scaledToFill()
                    .frame(width: 115, height: 115)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            } placeholder: {
                ProgressView()
            }
    }
}

struct CatBreedsGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsGridItemView(breed: CatBreed.mock)
    }
}
