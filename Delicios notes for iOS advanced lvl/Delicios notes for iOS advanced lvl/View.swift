//
//  View.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import SwiftUI
import RealmSwift

struct CategoryView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel = ObjectAlamofireService()
    var body: some View {
        VStack {
            Text("Category")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.top)
            ScrollView {
                VStack {
                    ForEach(viewModel.category.categories, id: \.idCategory) { category in
                        NavigationLink(destination: RecipesFromAPIView(catergoryView: viewModel, category: category)) {
                            HStack {
                                Text(category.strCategory)
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Spacer()
                                AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
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
                .padding(.vertical)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct FavouriteRecipe: View {
//    var body: some View {
//        
//    }
//}

struct RecipesFromAPIView: View {
    @Environment(\.colorScheme) private var colorScheme
    var catergoryView: ObjectAlamofireService
    var category: CategoryFromAPI
    var body: some View {

        Text("Category: \(category.strCategory)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .task {
                catergoryView.getRecipeCategory(category: category.strCategory)
            }
        HStack {
            ScrollView {
                Text(category.strCategoryDescription)
                    .padding()
                ForEach(catergoryView.recipes.meals, id: \.idMeal) { recipes in
                    NavigationLink(destination: RecipeFromAPIView(recipeView: catergoryView, recipe: recipes)) {
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
    }
}

struct RecipeFromAPIView: View {
    @Environment(\.colorScheme) private var colorScheme
    var recipeView: ObjectAlamofireService
    var recipe: RecipesFromApi
    var body: some View {
        VStack {
            Text("Recipe: \(recipe.strMeal)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .task() {
                    recipeView.getRecipe(recipe: recipe.strMeal)
                }
        }
        HStack {
            ScrollView {
                ForEach(recipeView.recipe.meals, id: \.idMeal) { recipeInstruction in
                    Text(recipeInstruction.strInstructions)
                        .font(.title3)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding()
                }
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
    }
}

struct RandomRecipeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel = ObjectAlamofireServiceRandomRecipe()
    var body: some View {
        VStack {
            Text("Recipes for every day")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.top)
            ScrollView {
                VStack {
                    ForEach(viewModel.randomRecipe, id: \.meals) { recipes in
                        ForEach(recipes.meals, id: \.idMeal) { recipe in
                            NavigationLink(destination: RandomRecipeInstructionView(viewModel: viewModel, recipe: recipe)) {
                                HStack {
                                    Text(recipe.strMeal)
                                        .font(.title3)
                                        .foregroundColor(.black)
                                    Spacer()
                                    AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
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
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
            
struct RandomRecipeInstructionView: View {
    @Environment(\.colorScheme) private var colorScheme
    var viewModel: ObjectAlamofireServiceRandomRecipe
    var recipe: RecipeFromApi
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
    }
}
