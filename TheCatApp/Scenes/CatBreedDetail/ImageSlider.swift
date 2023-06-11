//
//  ImageSlider.swift
//  TheCatApp
//
//  Created by Michael Slavev on 11.06.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine


public struct ImageSlider: View {
    
    public let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var selection = 0
        
    let images:[CatImage]
        

    public init(_ images:[CatImage]){
        
        self.images = images
    }
    
    public var body: some View {
        
        VStack{
            TabView(selection : $selection){
                
                ForEach(0..<images.count){ i in
                    
                    WebImage(url: images[i].url)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.container, edges: .top)
                }
                
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .onReceive(timer, perform: { _ in
                    withAnimation{
                        selection = selection < images.count ? selection + 1 : 0
                    }
                })
            
        }.frame(height: 300)
        
    }
}
