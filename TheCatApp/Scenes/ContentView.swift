//
//  ContentView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 05.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            NavigationView {
                //CatBreedsListView(viewModel: CatBreedListViewModel())
                CatBreedsListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "list.bullet.clipboard")
                
                Text("Breeds")
            }
            
            NavigationView {
                ZStack {
                    BackgroundGradientView()
                    
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("IMAGES!")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "photo.stack")
                
                Text("Images")
            }
            
            NavigationView {
                ZStack {
                    BackgroundGradientView()
                    
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("VOTE!")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "hand.thumbsup")
                
                Text("Vote")
            }
            
            NavigationView {
                ZStack {
                    BackgroundGradientView()
                    
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("LIKES")
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "heart.text.square")
                
                Text("Likes")
            }
        }
        .foregroundColor(.appTextBody)
        .preferredColorScheme(.none)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
