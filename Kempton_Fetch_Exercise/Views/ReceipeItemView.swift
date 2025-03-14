//
//  ReceipeItemView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct ReceipeItemView: View {
  let recipe: Recipe
  var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(url: URL(string: recipe.photoURLSmall)) { phase in
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
      .frame(width: 100, height: 100)
      Text(recipe.name)
        .font(.headline)
      Text(recipe.cuisine)
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .padding(.vertical, 4)
  }
}

#Preview {
  ReceipeItemView(recipe: Recipe(cuisine: "American", name: "Pancakes",
                                 photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                                 photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                                 sourceURL: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                                 uuid: "123",
                                 youtubeURL: nil))
}
