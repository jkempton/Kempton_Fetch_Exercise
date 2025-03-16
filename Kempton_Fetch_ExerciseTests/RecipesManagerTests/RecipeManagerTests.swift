//
//  RecipeManagerTests.swift
//  Kempton_Fetch_ExerciseTests
//
//  Created by Justin Kempton on 3/15/25.
//

import XCTest
import Combine
import Kempton_Fetch_Exercise

final class RecipeManagerTests: XCTestCase {
  
  var networkManager: MockNetworkManager!
  var recipeManager: RecipeManager!
  var alertManager: AlertManager!
  var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    networkManager = MockNetworkManager()
    alertManager = AlertManager()
    recipeManager = RecipeManager(alertManager: alertManager, networkManager: networkManager)
  }
  
  override func tearDown() {
    super.tearDown()
    cancellables.removeAll()
    recipeManager = nil
    networkManager = nil
    alertManager = nil
  }
  
  
  func testFetchRecipesSuccess() async {
    let expectation = XCTestExpectation(description: "Recipes fetched and sorted successfully")
    
    recipeManager.$sortedRecipes
      .dropFirst() // Ignore the initial value of sortedRecipes
      .sink { sortedRecipes in
        if sortedRecipes.count > 0 {
          // should be American, British, and French in mock data
          XCTAssertEqual(sortedRecipes.count, 3, "Expected 3 sorted recipes, but got \(sortedRecipes.count).")
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)
    
    Task {
      recipeManager.fetchRecipes()
    }
    
    
    // Wait for the expectation to be fulfilled or time out after 5 seconds
    await fulfillment(of: [expectation], timeout: 5)
  }
  
  func testFetchRecipesWithSearch() async {
    let searchedTerm = "Waffles"
    let expectation = XCTestExpectation(description: "Recipes fetched and filtered by search term")
    
    recipeManager.$sortedRecipes
      .dropFirst() // Ignore the initial value of sortedRecipes
      .sink { sortedRecipes in
        if sortedRecipes.count > 0 {
          // Verify that the sortedRecipes contains only recipes matching the search term
          let searchTerm = searchedTerm // Example search term
          let filteredRecipes = sortedRecipes.flatMap { $0 }.filter {
            $0.name.lowercased().contains(searchTerm.lowercased())
          }
          
          // should be contain 3 recipes with the word Waffles in them in mock data
          XCTAssertEqual(filteredRecipes.count, 3, "Expected 3 recipe to match search term: \(searchTerm), but got \(filteredRecipes.count).")
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)
    
    
    Task {
      await recipeManager.fetchRecipes()
      // Once the fetch is done, set a search term
      recipeManager.recipeSearch = searchedTerm
    }
    
    // Wait for the expectation to be fulfilled or time out after 5 seconds
    await fulfillment(of: [expectation], timeout: 5)
  }
  
  
  func testFetchRecipesWithError() async {
    // Create an expectation for the error to be handled correctly
    let expectation = XCTestExpectation(description: "Error handled correctly when fetching recipes")
    
    // Set an error to be thrown by the MockNetworkManager
    let expectedError = AlertError.badServerResponse
    networkManager.errorToThrow = expectedError
    
    alertManager.$alertError
      .sink { error in
        if let error = error {
          XCTAssertEqual(error.errorTitle, expectedError.errorTitle, "Expected the alertError to be set with the expected error.")
          XCTAssertEqual(error.errorDescription, expectedError.errorDescription, "Expected the alertError to be set with the expected error message.")
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)
    
    Task {
      await recipeManager.fetchRecipes()
    }
    
    // Wait for the expectation to be fulfilled or time out after 5 seconds
    await fulfillment(of: [expectation], timeout: 5)
  }



  
  
}
