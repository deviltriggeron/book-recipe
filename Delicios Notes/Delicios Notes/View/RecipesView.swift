//
//  RecipesView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var controller: Controller
    var category: CategoryFromAPI
    var body: some View {
        VStack {
            Text("Category: \(category.strCategory)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        NavigationStack {
            ScrollView {
                Text(category.strCategoryDescription)
                    .padding()
                ForEach(controller.publishedVar.recipes.meals, id: \.idMeal) { recipes in
                    NavigationLink(destination: RecipeView(controller: controller, recipe: recipes.strMeal)) {
                        HStack {
                            Text(recipes.strMeal)
                                .font(.title3)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                            AsyncImage(url: URL(string: recipes.strMealThumb)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        }
                        .frame(maxWidth: 300, minHeight: 60)
                        .padding()
                        .background(colorScheme == .dark ? Color.gray : Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                controller.getRecipeCategory(category: category.strCategory)
            }
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("Category: \(category.strCategory)")
//                        .font(.largeTitle)
//                        .accessibilityAddTraits(.isHeader)
//                }
//            }
        }
    }
}
