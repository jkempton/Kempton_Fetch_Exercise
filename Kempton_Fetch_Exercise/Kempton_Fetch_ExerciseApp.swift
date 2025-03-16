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
  @StateObject var alertManager: AlertManager

  init() {
    print("APP START 🚀")
    let networkManager = NetworkManager()
    let alertManager = AlertManager()
    let recipeManager = RecipeManager(alertManager: alertManager, networkManager: networkManager)
    let diskImageCacheManager = DiskImageCacheManager()
    _networkManager = StateObject(wrappedValue: networkManager)
    _recipeManager = StateObject(wrappedValue: recipeManager)
    _alertManager = StateObject(wrappedValue: alertManager)
    _diskImageCacheManager = StateObject(wrappedValue: diskImageCacheManager)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(recipeManager)
        .environmentObject(networkManager)
        .environmentObject(diskImageCacheManager)
        .alert(item: $alertManager.alertError) { error in
          Alert(
            title: Text(error.errorTitle),
            message: Text(error.errorDescription),
            dismissButton: .default(Text("OK")) {
              self.alertManager.alertError = nil // Clear error after dismissing
            }
          )
        }
    }
  }
}
