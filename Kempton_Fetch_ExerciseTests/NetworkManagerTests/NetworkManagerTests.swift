//
//  NetworkManagerTests.swift
//  Kempton_Fetch_ExerciseTests
//
//  Created by Justin Kempton on 3/15/25.
//

import XCTest
import Kempton_Fetch_Exercise

final class NetworkManagerTests: XCTestCase {

  var networkManager: MockNetworkManager!
  
  override func setUp() {
    super.setUp()
    networkManager = MockNetworkManager()
  }
  
  override func tearDown() {
    super.tearDown()
    networkManager = nil
  }
  
  func testFetchRecipesSuccess() async {
    do {
      let recipes = try await networkManager.fetchRecipes()
      XCTAssertEqual(recipes.count, 4, "Expected 4 recipes to be returned.")
    } catch {
      XCTFail("Fetch should not throw an error: \(error)")
    }
  }
  
  func testFetchRecipesMalformedData() async {
    let malformedError = AlertError.customError(title: "Malformed Data", subTitle: "The data format received is invalid.")
    networkManager.errorToThrow = malformedError

    do {
      _ = try await networkManager.fetchRecipes()
      XCTFail("Expected fetch to throw error, but it succeeded.")
    } catch let error as AlertError {
      XCTAssertEqual(error, malformedError)
    } catch {
      XCTFail("Unexpected error type: \(error)")
    }
  }
}
