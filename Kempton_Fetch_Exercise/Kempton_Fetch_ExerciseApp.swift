//
//  Kempton_Fetch_ExerciseApp.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

@main
struct Kempton_Fetch_ExerciseApp: App {
  
  @StateObject var networkManager: NetworkManager

  init() {
    print("APP START 🚀")
    let networkManager = NetworkManager()
    _networkManager = StateObject(wrappedValue: networkManager)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(networkManager)
    }
  }
}
