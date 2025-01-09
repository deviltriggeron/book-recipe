//
//  PublicVariable.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import Foundation

struct PublicVariable {
    var category: Categories
    var recipes: Recipes
    var recipe: Recipe
    var randomRecipe: [RecipeObject]
    var favorite: [FavoriteRecipeObject]
    
    init() {
        self.category = Categories(categories: [CategoryFromAPI(idCategory: "", strCategory: "", strCategoryThumb: "", strCategoryDescription: "")])
        self.recipes = Recipes(meals: [RecipesFromApi(idMeal: "", strMeal: "", strMealThumb: "")])
        self.recipe = Recipe(meals: [RecipeFromApi(idMeal: "", strMeal: "", strMealThumb: "", strInstructions: "")])
        self.randomRecipe = [RecipeObject]()
        self.favorite = [FavoriteRecipeObject]()
    }
}
