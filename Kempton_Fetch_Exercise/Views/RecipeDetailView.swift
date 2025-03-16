//
//  RecipeDetailView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/15/25.
//

import SwiftUI

struct RecipeDetailView: View {
  let recipe: Recipe
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(recipe.cuisine)
        .font(.headline)
      CachedAsyncImageView(url: URL(string: recipe.photoURLLarge)) { phase in
        switch phase {
        case .empty:
          Rectangle()
            .fill(.clear)
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
              ProgressView()
                .scaleEffect(3)
            )
        case .success(let image):
          image
            .resizable()
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
        case .failure:
          ImageLoadingFailureView(size: CGSize(width: 100, height: 100))
        @unknown default:
          let _ = print("Unexpected AsyncImagePhase case encountered.")
          fatalError()
        }
      }
      if let sourceURL = recipe.sourceURL {
        Link("Recipe Source", destination: URL(string: sourceURL)!)
          .font(.headline)
          .foregroundColor(.blue)
          .underline()
      }
      if let youtubeURL = recipe.youtubeURL {
        Link("YouTube Video", destination: URL(string: youtubeURL)!)
          .font(.headline)
          .foregroundColor(.blue)
          .underline()
      }
      Spacer()
    }
    .padding(16)
    .navigationTitle(recipe.name)
  }
}


#Preview {
  RecipeDetailView(recipe: Recipe(cuisine: "American", name: "Pancakes",
                                  photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                                  photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                                  sourceURL: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                                  uuid: "123",
                                  youtubeURL: nil))
  .environmentObject(DiskImageCacheManager())
}
