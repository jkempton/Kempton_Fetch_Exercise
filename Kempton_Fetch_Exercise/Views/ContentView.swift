//
//  ContentView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var recipeManager: RecipeManager

  var body: some View {
    NavigationView {
      VStack {
        RecipesSearchView(searchRecipe: $recipeManager.recipeSearch)
        List {
          if recipeManager.sortedRecipes.isEmpty {
            Text("No recipes found")
              .font(.title2)
              .foregroundColor(.gray)
              .padding()
              .listRowSeparator(.hidden)
          } else {
            ForEach(recipeManager.sortedRecipes, id: \.first?.cuisine) { recipes in
              if let cuisine = recipes.first?.cuisine {
                Section(header: Text(cuisine).font(.headline)) {
                  ForEach(recipes, id: \.uuid) { recipe in
                    RecipeItemView(recipe: recipe)
                  }
                }
              }
            }
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



#Preview {
  ContentView()
    .environmentObject(DiskImageCacheManager())
    .environmentObject(RecipeManager(alertManager: AlertManager(), networkManager: NetworkManager()))
}
