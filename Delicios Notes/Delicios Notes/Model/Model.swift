//
//  Model.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import Foundation

struct CategoryFromAPI: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

struct Categories: Decodable {
    let categories: [CategoryFromAPI]
}

struct RecipesFromApi: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct Recipes: Decodable {
    let meals: [RecipesFromApi]
}

struct RecipeFromApi: Decodable, Identifiable, Hashable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    
    var id: String { idMeal }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
        hasher.combine(strMeal)
        hasher.combine(strMealThumb)
        hasher.combine(strInstructions)
    }
    
    static func ==(lhs: RecipeFromApi, rhs: RecipeFromApi) -> Bool {
        return lhs.idMeal == rhs.idMeal &&
               lhs.strMeal == rhs.strMeal &&
               lhs.strMealThumb == rhs.strMealThumb &&
               lhs.strInstructions == rhs.strInstructions
    }
}

struct Recipe: Decodable {
    let meals: [RecipeFromApi]
}
