//
//  Controller.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import Foundation
import RxSwift

class Controller: ObservableObject {
    let service: AlamofireService
    let database: Database
    
    init(service: AlamofireService, database: Database) {
        self.service = service
        self.database = database
    }
    
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
    
    func dateUpdate() {
        let dateInt = getDate()
        if isFirstLaunch() {
            do {
                let date: DateObject = DateObject(day: dateInt)
                _ = try database.createDate(date: date)
                getTenRandomRecipes()
            } catch {
                print("error first")
            }
        } else {
            do {
                let date: DateObject = DateObject(day: dateInt)
                let dateArray = database.readDate()
                if dateArray[0].day != date.day {
                    _ = try database.updateDate(updatedDate: dateArray[0], newDate: dateInt)
                    let randomRecipeArray = database.readRandomRecipe()
                    for deletedIndex in 0...database.readRandomRecipe().count - 1 {
                        _ = try database.deleteRandomRecipe(deletedRecipe: randomRecipeArray[deletedIndex])
                    }
                    getTenRandomRecipes()
                }
            } catch {
                print("error not first")
            }
        }
    }
    
    private func isFirstLaunch() -> Bool {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "HasLaunchedBefore")
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
        }
        return isFirstLaunch
    }
    
    func getTenRandomRecipes() {
        for _ in 0..<10 {
            service.addRandomRecipeToDatabase()
        }
    }
    
    func getRandomRecipe() {
        self.publishedVar.randomRecipe = database.readRandomRecipe()
    }
    
    func getDate() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: date)
        return currentDay
    }
}
