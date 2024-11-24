//
//  ContentView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                CategoryView()
            }
                .tabItem() {
                    Image(systemName: "house")
                        .foregroundStyle(.black)
                    Text("Category")
                        .foregroundColor(.black)
                }
            NavigationView {
                RandomRecipeView()
            }
                .tabItem() {
                    Image(systemName: "leaf")
                        .foregroundStyle(.black)
                    Text("Recipes for every day")
                        .foregroundColor(.black)
                }
            
            Text("Favourites")
                .tabItem() {
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                    Text("Favourites")
                        .foregroundColor(.black)
                }
        }
    }
}

#Preview {
    ContentView()
}
