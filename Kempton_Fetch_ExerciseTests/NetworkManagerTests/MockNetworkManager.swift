//
//  MockNetworkManager.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/15/25.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
  
  var errorToThrow: AlertError?
  
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
    Recipe(cuisine: "British", name: "Waffles British",
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
  
  func fetchRecipes() async throws -> [Recipe] {
    if let error = errorToThrow {
      throw error  // If we have an error to throw, we throw it.
    }
    return recipes
  }
  
}
