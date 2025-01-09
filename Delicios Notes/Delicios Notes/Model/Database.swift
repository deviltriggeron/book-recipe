//
//  Database.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 27.12.2024.
//

import Foundation
import RealmSwift

class Database: ObservableObject {
    
    static let shared = Database()
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    // MARK: Date data base
    func createDate(date: DateObject) throws -> Bool {
        guard realm.object(ofType: DateObject.self, forPrimaryKey: date.id) == nil else {
            return false
        }
        
        try realm.write() {
            realm.add(date)
        }
        
        return true
    }
    
    func readDate() -> [DateObject] {
        return Array(realm.objects(DateObject.self))
    }
    
    func updateDate(updatedDate: DateObject, newDate: Int? = nil) throws -> Bool {
        guard let updatedObj = realm.object(ofType: DateObject.self, forPrimaryKey: updatedDate.id) else {
            return false
        }
        
        try realm.write() {
            updatedObj.day = newDate ?? updatedObj.day
        }
        
        return true
    }
    
    func deleteDate(deletedDate: DateObject) throws -> Bool {
        guard let deletedObj = realm.object(ofType: DateObject.self, forPrimaryKey: deletedDate.id) else {
            return false
        }
        
        try realm.write() {
            realm.delete(deletedObj)
        }
        
        return true
    }
    
    // MARK: random recipe data base
    func createRandomRecipe(recipe: RecipeObject) throws -> Bool {
        guard realm.object(ofType: RecipeObject.self, forPrimaryKey: recipe.idMeal) == nil else {
            return false
        }
        
        try realm.write() {
            realm.add(recipe)
        }
        
        return true
    }
    
    func readRandomRecipe() -> [RecipeObject] {
        return Array(realm.objects(RecipeObject.self))
    }
    
    func updateRandomRecipe(recipe: RecipeObject, newRecipe: RecipeObject) throws -> Bool {
        guard let updatedObj = realm.object(ofType: RecipeObject.self, forPrimaryKey: recipe.idMeal) else {
            return false
        }
        
        try realm.write() {
            updatedObj.idMeal = newRecipe.idMeal
            updatedObj.strMeal = newRecipe.strMeal
            updatedObj.strMealThumb = newRecipe.strMealThumb
            updatedObj.strInstructions = newRecipe.strInstructions
        }
        return true
    }
    
    func deleteRandomRecipe(deletedRecipe: RecipeObject) throws -> Bool {
        guard let deletedObj = realm.object(ofType: RecipeObject.self, forPrimaryKey: deletedRecipe.idMeal) else {
            return false
        }
        
        try realm.write() {
            realm.delete(deletedObj)
        }
        
        return true
    }
    
    // MARK: Favorite recipe data base
    
    func createFavoriteRecipe(favoriteRecipe: FavoriteRecipeObject) throws -> Bool {
        guard realm.object(ofType: FavoriteRecipeObject.self, forPrimaryKey: favoriteRecipe.idMeal) == nil else {
            return false
        }
        
        try realm.write() {
            realm.add(favoriteRecipe)
        }
        
        return true
    }
    
    func readFavoriteRecipe() -> [FavoriteRecipeObject] {
        return Array(realm.objects(FavoriteRecipeObject.self))
    }
    
    func updateFavoriteRecipe(favoriteRecipe: FavoriteRecipeObject, newFavoriteRecipe: FavoriteRecipeObject) throws -> Bool {
        guard let favoriteRecipeObj = realm.object(ofType: FavoriteRecipeObject.self, forPrimaryKey: favoriteRecipe.idMeal) else {
            return false
        }
        
        try realm.write() {
            favoriteRecipeObj.idMeal = newFavoriteRecipe.idMeal
            favoriteRecipeObj.strMeal = newFavoriteRecipe.strMeal
            favoriteRecipeObj.strInstructions = newFavoriteRecipe.strInstructions
            favoriteRecipeObj.strMealThumb = newFavoriteRecipe.strMealThumb
        }
        
        return true
    }
    
    func deleteFavoriteRecipe(favoriteRecipe: FavoriteRecipeObject) throws -> Bool {
        guard let favoriteRecipeObj = realm.object(ofType: FavoriteRecipeObject.self, forPrimaryKey: favoriteRecipe.idMeal) else {
            return false
        }
        
        try realm.write() {
            realm.delete(favoriteRecipeObj)
        }
        
        return true
    }
    
    func search(strMeal: String) throws -> [FavoriteRecipeObject?] {
        return Array(realm.objects(FavoriteRecipeObject.self).filter("strMeal CONTAINS[cd] %@", strMeal))
    }

    
    // MARK: delete data base
    
    func clear() throws {
        try realm.write() {
            realm.deleteAll()
        }
    }

}
