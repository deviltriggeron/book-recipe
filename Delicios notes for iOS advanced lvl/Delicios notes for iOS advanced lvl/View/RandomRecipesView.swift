//
//  RandomRecipesView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import SwiftUI

struct RandomRecipeView: View {
    @Environment(\.colorScheme) private var colorScheme
    var container: Injection
    @StateObject var controller: Controller
    @State var database: Database
    init(container: Injection) {
        _controller = StateObject(wrappedValue: container.resolve(Controller.self)!)
        _database = State(wrappedValue: container.resolve(Database.self)!)
        self.container = container
    }
    var body: some View {
        ScrollView {
            ForEach(database.readRandomRecipe(), id: \.idMeal) { recipe in
                NavigationLink(destination: RandomRecipeInstructionView(recipe: recipe)) {
                    HStack {
                        Text("\(recipe.strMeal)")
                            .font(.title3)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black) // GOOD
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
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Recipes for every day")
                        .font(.largeTitle)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .onAppear() {
                dateUpdate()
        }
    }
    
    private func dateUpdate() {
        let dateInt = controller.getDate()
        if isFirstLaunch() {
            do {
                let date: DateObject = DateObject(day: dateInt)
                _ = try database.createDate(date: date)
                controller.getTenRandomRecipes()
            } catch {
                print("error first")
            }
        } else {
            do {
                let date: DateObject = DateObject(day: dateInt)
                let dateArray = database.readDate()
                if dateArray[0].day != date.day {
                    _ =  try database.updateDate(updatedDate: dateArray[0], newDate: dateInt)
                    
                    controller.getTenRandomRecipes()
                }
            } catch {
                print("error not first")
            }
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
