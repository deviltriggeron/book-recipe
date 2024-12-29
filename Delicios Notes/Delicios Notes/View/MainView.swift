//
//  ContentView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import SwiftUI

struct MainView: View {
    @State var container: Injection
    var body: some View {
        TabView {
            NavigationView {
                CategoryView(container: container)
            }
                .tabItem() {
                    Image(systemName: "book.closed")
                        .foregroundStyle(.black)
                    Text("Category")
                        .foregroundColor(.black)
                }
            NavigationView {
                RandomRecipeView(container: container)
            }
                .tabItem() {
                    Image(systemName: "book")
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
//
//#Preview {
//    var container: Injection = Injection()
//    MainView(container: container)
//}
