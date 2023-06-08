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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CCatBreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailView(viewModel: CatBreedDetailViewModel(id: "abys"))
    }
}
