//
//  RecipeManager.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import Combine
import SwiftUI


class RecipeManager: NSObject, ObservableObject {
  let networkManager: any NetworkManagerProtocol
  @Published private var recipes: [Recipe] = []
  @Published private(set) var sortedRecipes: [[Recipe]] = []
  @Published var recipeSearch = ""
  private var cancellables: Set<AnyCancellable> = []
  
  init(networkManager: any NetworkManagerProtocol) {
    self.networkManager = networkManager
    super.init()
    fetchRecipes()
    
    Publishers.CombineLatest($recipes, $recipeSearch)
      .map { (recipes, searchTerm) in
        if searchTerm.isEmpty {
          let grouped = Dictionary(grouping: recipes, by: { $0.cuisine })
          return grouped.values
            .map { $0.sorted { $0.name < $1.name } }
            .sorted { $0.first?.cuisine ?? "" < $1.first?.cuisine ?? "" } // Sort cuisines alphabetically
        } else {
          
          // Filter recipes based on searchTerm (case-insensitive search by name)
          let filteredRecipes = recipes.filter { recipe in
            recipe.name.lowercased().contains(searchTerm.lowercased())
          }
          
          // Group by cuisine and sort each group by recipe name
          let groupedRecipes = Dictionary(grouping: filteredRecipes, by: { $0.cuisine })
            .mapValues { $0.sorted { $0.name < $1.name } }  // Sort by name within each cuisine
          
          // Return the sorted values as an array
          return groupedRecipes.values.sorted { $0.first?.cuisine ?? "" < $1.first?.cuisine ?? "" }
        }
      }
      .assign(to: &$sortedRecipes)
  }
  
  func fetchRecipes() {
    Task { @MainActor in
      do {
        self.recipes = try await networkManager.fetchRecipes()
      } catch {
        // If it's an error we don't specifically handle, just print it for now
        print("❌ An unexpected error occurred: \(error)")
      }
    }
  }
}
