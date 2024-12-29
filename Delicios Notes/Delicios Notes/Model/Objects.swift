//
//  Objects.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 27.12.2024.
//

import Foundation
import RealmSwift

class DateObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var day: Int
    
    convenience init(day: Int) {
        self.init()
        self.day = day
    }
}

class RecipeObject: Object, Identifiable {
    @Persisted(primaryKey: true) var idMeal: String
    @Persisted var strMeal: String
    @Persisted var strMealThumb: String
    @Persisted var strInstructions: String
    
    convenience init(idMeal: String, strMeal: String, strMealThumb: String, strInstructions: String) {
        self.init()
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strInstructions = strInstructions
    }
}

class FavoriteRecipeObject: Object, Identifiable {
    @Persisted(primaryKey: true) var idMeal: String
    @Persisted var strMeal: String
    @Persisted var strMealThumb: String
    @Persisted var strInstructions: String
    
    convenience init(idMeal: String, strMeal: String, strMealThumb: String, strInstructions: String) {
        self.init()
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strInstructions = strInstructions
    }
}
