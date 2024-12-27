//
//  AlamofireService.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import RxSwift
import Alamofire


class AlamofireService: ObservableObject {
    
    var database = Database.shared
    
    let bag = DisposeBag()
    
    func getCategories() -> Observable<Categories> {
        let urlCategories: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
        return Observable.create { observer in
            AF.request(urlCategories, method: .get).responseDecodable(of: Categories.self) { response in
                switch response.result {
                case .success(let categoryResponse):
                    observer.onNext(categoryResponse)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    
    func getRecipeCategory(category: String) -> Observable<Recipes> {
        let urlRecipes: String = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        return Observable.create { observer in
            AF.request(urlRecipes, method: .get).responseDecodable(of: Recipes.self) { response in
                switch response.result {
                case .success(let recipesResponse):
                    observer.onNext(recipesResponse)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func getRecipe(recipe: String) -> Observable<Recipe> {
        let urlRecipe: String = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(recipe)"
        return Observable.create { observer in
            AF.request(urlRecipe, method: .get).responseDecodable(of: Recipe.self) { response in
                switch response.result {
                case .success(let recipeFromResponse):
                    observer.onNext(recipeFromResponse)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func addRandomRecipeToDatabase() {
        self.getRandomRecipe().subscribe(onNext: { [ weak self ] response in
            self?.typeCastAndAdd(response)
            print("Random recipe loaded")
        }, onError: { error in
            print("Error load random recipe")
        }).disposed(by: bag)
    }
    
    func getRandomRecipe() -> Observable<RandomRecipe> {
        let urlRandomRecipe: String = "https://www.themealdb.com/api/json/v1/1/random.php"
        return Observable.create { observer in
            AF.request(urlRandomRecipe, method: .get).responseDecodable(of: RandomRecipe.self) { response in
                switch response.result {
                case .success(let randomRecipe):
                    observer.onNext(randomRecipe)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func typeCastAndAdd(_ response: RandomRecipe) {
        for recipe in response.meals {
            let responseRecipe: RecipeObject = RecipeObject(idMeal: recipe.idMeal, strMeal: recipe.strMeal, strMealThumb: recipe.strMealThumb, strInstructions: recipe.strInstructions)
            do {
                let result = try database.createRandomRecipe(recipe: responseRecipe)
            } catch {
                print("error add database")
            }
        }
    }
}
