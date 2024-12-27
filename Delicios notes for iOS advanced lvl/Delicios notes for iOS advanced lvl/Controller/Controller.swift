//
//  Controller.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import Foundation
import RxSwift

class Controller: ObservableObject {
    let service: AlamofireService = AlamofireService()
    
    @Published var publishedVar: PublicVariable = PublicVariable()
    
    let bag = DisposeBag()
    
    func getCategories() {
        service.getCategories().subscribe(onNext: { [weak self] response in
            self?.handleGetResult(response)
            print("Category loaded")
        }, onError: { error in
            print("Error load category")
        }).disposed(by: bag)
    }
    
    private func handleGetResult(_ response: Categories) {
        self.publishedVar.category = response
    }
    
    func getRecipeCategory(category: String) {
        service.getRecipeCategory(category: category).subscribe(onNext: { [ weak self ] response in
            self?.handleGetResult(response)
            print("Recipes loaded")
        }, onError: { error in
            print("Error load recipes")
        }).disposed(by: bag)
    }
    
    private func handleGetResult(_ response: Recipes) {
        self.publishedVar.recipes = response
    }
    
    func getRecipe(recipe: String) {
        service.getRecipe(recipe: recipe).subscribe(onNext: { [ weak self ] response in
            self?.handleGetResult(response)
            print("Recipe loaded")
        }, onError: { error in
            print("Error load recipe")
        }).disposed(by: bag)
    }
    
    private func handleGetResult(_ response: Recipe) {
        self.publishedVar.recipe = response
    }
    
    func getTenRandomRecipes() {
        for _ in 0..<10 {
            service.addRandomRecipeToDatabase()
        }
    }
    
//    func getRandomRecipe() {
//        service.getRandomRecipe().subscribe(onNext: { [ weak self ] response in
//            self?.handleGetResult(response)
//            print("Random recipe loaded")
//        }, onError: { error in
//            print("Error load random recipe")
//        }).disposed(by: bag)
//    }
//    
//    private func handleGetResult(_ response: RandomRecipe) {
//        self.publishedVar.randomRecipe.append(response)
//    }
    
    func getDate() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: date)
        return currentDay
    }
}
