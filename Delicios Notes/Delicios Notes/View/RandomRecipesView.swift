//
//  RandomRecipesView.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 25.12.2024.
//

import SwiftUI

struct RandomRecipeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var container: Injection
    @StateObject var controller: Controller
    init(container: Injection) {
        _controller = StateObject(wrappedValue: container.resolve(Controller.self)!)
        self.container = container
    }
    var body: some View {
        ScrollView {
            ForEach(controller.publishedVar.randomRecipe, id: \.idMeal) { recipe in
                NavigationLink(destination: RandomRecipeInstructionView(controller: controller, recipe: recipe)) {
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
            controller.dateUpdate()
            controller.getRandomRecipe()
        }
    }
}
