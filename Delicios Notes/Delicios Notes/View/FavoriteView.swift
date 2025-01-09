//
//  FavoriteView.swift
//  Delicios Notes
//
//  Created by Starfighter Dollie on 06.01.2025.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var container: Injection
    @StateObject var controller: Controller
    
    let columns = [GridItem(.flexible(minimum: 50, maximum: 175)), GridItem(.flexible(minimum: 50, maximum: 175))]
    
    init(container: Injection) {
        _controller = StateObject(wrappedValue: container.resolve(Controller.self)!)
        self.container = container
    }
    
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(controller.publishedVar.favorite) { favorite in
                        NavigationLink(destination: RecipeView(controller: controller, recipe: favorite.strMeal)) {
                        VStack {
                            HStack {
                                AsyncImage(url: URL(string: favorite.strMealThumb)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                            Text("\(favorite.strMeal)")
                                .font(.callout)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
        .padding()
            
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Favorites")
                    .font(.largeTitle)
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .onAppear() {
            controller.getFromDataBase()
        }
    }
}

//#Preview {
//    FavoriteView()
//}
