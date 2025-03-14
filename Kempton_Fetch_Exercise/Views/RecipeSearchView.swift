//
//  RecipeSearchView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct RecipesSearchView: View {
  @Binding var searchRecipe: String
  var body: some View {
    TextField("", text: $searchRecipe)
      .placeholder(when: searchRecipe.isEmpty) {
        Text("Search recipes").foregroundColor(Color.gray)
      }
      .disableAutocorrection(true)
      .padding(7)
      .padding(.horizontal, 25)
      .background(Color.white)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 1)
      )
      .overlay(RecipeSearchOverlayView(searchRecipe: $searchRecipe))
      .padding(.horizontal, 15)
  }
}

struct RecipeSearchOverlayView: View {
  @Binding var searchRecipe: String
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(Color.gray)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 8)
      Button(action: {
        self.searchRecipe = ""
      }, label: {
        Image(systemName: "multiply.circle.fill")
          .foregroundColor(Color.gray)
          .padding(.trailing, 7)
      })
    }
  }
}

#Preview {
  RecipesSearchView(searchRecipe: .constant("Pie"))
}
