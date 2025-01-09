//
//  View.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import SwiftUI
import RealmSwift

struct CategoryView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var container: Injection
    @StateObject var controller: Controller
    
    init(container: Injection) {
        _controller = .init(wrappedValue: container.resolve(Controller.self)!)
        self.container = container
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(controller.publishedVar.category.categories, id: \.idCategory) { category in
                    NavigationLink(destination: RecipesView(controller: controller, category: category)) {
                        HStack {
                            Text(category.strCategory)
                                .font(.title3)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            Spacer()
                            AsyncImage(url: URL(string: category.strCategoryThumb)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
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
                    Text("Category")
                        .font(.largeTitle)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .onAppear() {
                controller.getCategories()
            }
        }
    }
}
