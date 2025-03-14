//
//  Kempton_Fetch_ExerciseApp.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

@main
struct Kempton_Fetch_ExerciseApp: App {
  
  @StateObject var recipeManager: RecipeManager
  @StateObject var networkManager: NetworkManager
  @StateObject var diskImageCacheManager: DiskImageCacheManager

  init() {
    print("APP START 🚀")
    let networkManager = NetworkManager()
    let recipeManager = RecipeManager(networkManager: networkManager)
    let diskImageCacheManager = DiskImageCacheManager()
    _networkManager = StateObject(wrappedValue: networkManager)
    _recipeManager = StateObject(wrappedValue: recipeManager)
    _diskImageCacheManager = StateObject(wrappedValue: diskImageCacheManager)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(recipeManager)
        .environmentObject(networkManager)
        .environmentObject(diskImageCacheManager)
    }
  }
}
