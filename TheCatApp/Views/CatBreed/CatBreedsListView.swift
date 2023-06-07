//
//  CatBreedListView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import SwiftUI

struct CatBreedsListView: View {
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            
        }
    }
}

struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsListView()
    }
}
