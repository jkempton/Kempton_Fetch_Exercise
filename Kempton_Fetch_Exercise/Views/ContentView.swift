//
//  ContentView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct ContentView: View {
  
  private let recipes = [
    Recipe(cuisine: "American", name: "Pancakes",
           photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
           photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
           sourceURL: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
           uuid: "123", youtubeURL: nil),
    Recipe(cuisine: "American", name: "Waffles",
           photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
           photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
           sourceURL: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
           uuid: "124", youtubeURL: nil),
    Recipe(cuisine: "British", name: "Waffles",
           photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
           photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
           sourceURL: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
           uuid: "125", youtubeURL: nil),
    Recipe(cuisine: "French", name: "Waffles",
           photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
           photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
           sourceURL: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
           uuid: "126", youtubeURL: nil)
  ]
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          // Group recipes by cuisine
          ForEach(groupedRecipes.keys.sorted(), id: \.self) { cuisine in
            Section(header: Text(cuisine).font(.headline)) {
              // Use the specific cuisine recipes
              ForEach(groupedRecipes[cuisine] ?? [], id: \.uuid) { recipe in
                Text(recipe.name)
              }
            }
          }
        }
        .navigationTitle("Recipes")
        .environment(\.defaultMinListRowHeight, 0)
        .listStyle(.plain)
      }
    }
  }
  
  // Group the recipes by their cuisine
  private var groupedRecipes: [String: [Recipe]] {
    Dictionary(grouping: recipes, by: { $0.cuisine })
  }
}



#Preview {
  ContentView()
}
