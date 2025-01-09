//
//  RecipeView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import SwiftUI

struct RecipeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var controller: Controller
    var recipe: String
    @State var favoriteStatus: Bool = false
    var body: some View {
        VStack {
            Text("Recipe: \(recipe)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        ScrollView {
            ForEach(controller.publishedVar.recipe.meals, id: \.idMeal) { recipeInstruction in
                Text(recipeInstruction.strInstructions)
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                AsyncImage(url: URL(string: recipeInstruction.strMealThumb)) { image in
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
        .navigationBarTitleDisplayMode(.inline)
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

        .onAppear {
            controller.getRecipe(recipe: recipe)
            favoriteStatus = controller.searchRecipeInDatabase(name: recipe)
        }
    }
    
    private func addRecipeToFavorite() {
        controller.addToDataBase(recipe: recipe)
    }
    
    private func deleteRecipeFromFavorite() {
        controller.removeFromDataBase(recipe: recipe)
    }

}

