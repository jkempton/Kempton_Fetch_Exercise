//
//  ContentView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var recipeManager: RecipeManager
  @State private var scrollToTop = false
  var body: some View {
    NavigationView {
      VStack {
        RecipesSearchView(searchRecipe: $recipeManager.recipeSearch, scrollToTop: $scrollToTop)
        ScrollViewReader { proxy in
          List {
            if recipeManager.sortedRecipes.isEmpty {
              Text("No recipes found")
                .font(.title2)
                .foregroundColor(.gray)
                .padding()
                .listRowSeparator(.hidden)
            } else {
              ForEach(Array(recipeManager.sortedRecipes.enumerated()), id: \.element.first?.cuisine) { index, recipes in
                Section(header: Text(recipes.first?.cuisine ?? "Uknown Cuisine").font(.headline)) {
                  ForEach(recipes, id: \.uuid) { recipe in
                    RecipeItemView(recipe: recipe)
                  }
                }
                .id(index)
              }
            }
          }
          .onChange(of: scrollToTop) { scrollToTop in
            if scrollToTop {
              proxy.scrollTo(0, anchor: .bottom)
              self.scrollToTop = false
            }
          }
          .navigationTitle("Recipes")
          .environment(\.defaultMinListRowHeight, 0)
          .listStyle(.plain)
          .scrollDismissesKeyboard(.immediately)
          .refreshable {
            recipeManager.fetchRecipes()
          }
        }
      }
    }
  }
}


#Preview {
  ContentView()
    .environmentObject(DiskImageCacheManager())
    .environmentObject(RecipeManager(alertManager: AlertManager(), networkManager: NetworkManager()))
}
