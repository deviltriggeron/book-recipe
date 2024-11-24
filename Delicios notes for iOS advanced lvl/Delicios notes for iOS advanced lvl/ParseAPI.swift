//
//  ParseAPI.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import Foundation
import Alamofire

struct CategoryFromAPI: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    
//    var id: String { idCategory }
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

struct RandomRecipe: Decodable {
    let meals: [RecipeFromApi]
}

class ObjectAlamofireService: ObservableObject {
    @Published var category: Categories = Categories(categories: [CategoryFromAPI(idCategory: "", strCategory: "", strCategoryThumb: "", strCategoryDescription: "")])
    @Published var recipes: Recipes = Recipes(meals: [RecipesFromApi(idMeal: "", strMeal: "", strMealThumb: "")])
    @Published var recipe: Recipe = Recipe(meals: [RecipeFromApi(idMeal: "", strMeal: "", strMealThumb: "", strInstructions: "")])
    
//    @Published var dataSource = DataSource.shared
    init() {
        getCategories()
    }
    
    func getCategories() {
        let urlCategories: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
        AF.request(urlCategories, method: .get).responseDecodable(of: Categories.self) { response in
            switch response.result {
            case .success(let category):
//                self.dataSource.saveToRealm(category)
                self.category = category
            case .failure(let error):
                print("Decodable error:\(error)")
            }
        }
    }
    
    func getRecipeCategory(category: String) {
        let urlRecipes: String = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        AF.request(urlRecipes, method: .get).responseDecodable(of: Recipes.self) { response in
            switch response.result {
            case .success(let recipe):
//                self.dataSource.saveToRealm(recipe)
                self.recipes = recipe
            case .failure(let error):
                print("Decodable error for recipes:\(error)")
            }
        }
    }
    
    func getRecipe(recipe: String) {
        let urlRecipe: String = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(recipe)"
        AF.request(urlRecipe, method: .get).responseDecodable(of: Recipe.self) { response in
            switch response.result {
            case .success(let recipeFromResponse):
                self.recipe = recipeFromResponse
            case .failure(let error):
                print("Decodable error for recipe:\(error)")
            }
        }
    }
    
}

class ObjectAlamofireServiceRandomRecipe: ObservableObject {
    @Published var randomRecipe = [RandomRecipe]()
    
    init() {
        for _ in 0..<10 {
            getRandomRecipe()
        }
    }
    
    func getRandomRecipe() {
        let urlRandomRecipe: String = "https://www.themealdb.com/api/json/v1/1/random.php"
        AF.request(urlRandomRecipe, method: .get).responseDecodable(of: RandomRecipe.self) { response in
            switch response.result {
            case .success(let randomRecipe):
                self.randomRecipe.append(randomRecipe)
            case .failure(let error):
                print("Decodable error for random recipes:\(error)")
            }
        }
    }
}
