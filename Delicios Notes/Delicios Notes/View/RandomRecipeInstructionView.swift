//
//  RandomRecipeInstructionView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 27.12.2024.
//

import SwiftUI

struct RandomRecipeInstructionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var controller: Controller
    var recipe: RecipeObject
    @State var favoriteStatus: Bool = false
    var body: some View {
        VStack {
            Text("Recipe: \(recipe.strMeal)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        HStack {
            ScrollView {
                Text(recipe.strInstructions)
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
        }
        .toolbar() {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favoriteStatus.toggle()
                    favoriteStatus ? addRecipeToFavorite() : deleteRecipeFromFavorite()
                }, label: {
                    if favoriteStatus {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")
                    }
                })
            }
        }
        .onAppear() {
            favoriteStatus = controller.searchRecipeInDatabase(name: recipe.strMeal)
        }
    }
    
    private func addRecipeToFavorite() {
        controller.addToDataBaseFromRandom(recipe: recipe)
    }
    
    private func deleteRecipeFromFavorite() {
        controller.removeFromDataBase(recipe: recipe)
    }
    

}
