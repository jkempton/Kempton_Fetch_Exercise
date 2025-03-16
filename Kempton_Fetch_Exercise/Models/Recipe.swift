//
//  Recipe.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import Foundation

struct Recipes: Codable {
  let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
  let cuisine, name: String
  let photoURLLarge, photoURLSmall: String
  let sourceURL: String?
  let uuid: String
  let youtubeURL: String?
  
  enum CodingKeys: String, CodingKey {
    case cuisine, name
    case photoURLLarge = "photo_url_large"
    case photoURLSmall = "photo_url_small"
    case sourceURL = "source_url"
    case uuid
    case youtubeURL = "youtube_url"
  }
}
