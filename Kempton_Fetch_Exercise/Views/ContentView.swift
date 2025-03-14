//
//  ContentView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject private var networkManager: NetworkManager
  @State private var recipes: [Recipe] = []
  
  // Group the recipes by their cuisine
  private var groupedRecipes: [String: [Recipe]] {
    Dictionary(grouping: recipes, by: { $0.cuisine })
  }
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          if recipes.isEmpty {
            Text("No recipes found")
              .font(.title2)
              .foregroundColor(.gray)
              .padding()
              .listRowSeparator(.hidden)
          } else {
            // Group recipes by cuisine
            ForEach(groupedRecipes.keys.sorted(), id: \.self) { cuisine in
              Section(header: Text(cuisine).font(.headline)) {
                // Use the specific cuisine recipes
                ForEach(groupedRecipes[cuisine] ?? [], id: \.uuid) { recipe in
                  ReceipeItemView(recipe: recipe)
                }
              }
            }
          }
        }
        .navigationTitle("Recipes")
        .environment(\.defaultMinListRowHeight, 0)
        .listStyle(.plain)
        .task {
          do {
            self.recipes = try await networkManager.fetchRecipes()
          } catch {
            print("❌ An unexpected error occurred: \(error)")
          }
        }
      }
    }
  }
}



#Preview {
  ContentView()
    .environmentObject(DiskImageCacheManager())
    .environmentObject(NetworkManager())
}
