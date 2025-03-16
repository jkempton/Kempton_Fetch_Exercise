//
//  NetworkManager.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import Foundation

protocol NetworkManagerProtocol {
  func fetchRecipes() async throws -> [Recipe]
}


class NetworkManager: NetworkManagerProtocol, ObservableObject {
  
  // add more individual network calls as we scale here
  func fetchRecipes() async throws -> [Recipe] {
    let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    return try await request(url: url, method: .GET, as: Recipes.self).recipes
  }
  
  // Reusable API call for GET & POST requests
  private func request<T: Decodable>(url: URL,
                             method: HTTPMethod = .GET,
                             body: Data? = nil,
                             headers: [String: String] = [:],
                             as type: T.Type) async throws -> T {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    request.allHTTPHeaderFields = headers
    
    // Set default Content-Type for POST requests
    if method == .POST, headers["Content-Type"] == nil {
      // create a custom error
      throw AlertError.customError(title: "Bad Request", subTitle: "Missing Content-Type in POST request")
    }
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      // This handles the case where the response is NOT an HTTPURLResponse.
      throw AlertError.badServerResponse
    }
    
    guard httpResponse.statusCode == 200 else {
      // we can get more detailed with individual error code messages and add cases the the AlertError enum as we scale
      throw AlertError.customError(title: "Something Went Wrong", subTitle: "Unexpected response from the server. (Code: \(httpResponse.statusCode))")
    }

    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      // Per directions showing an error with Malformed Data
      throw AlertError.customError(title: "Malformed Data", subTitle: "The data format received is invalid.")
    }
  }
}


enum HTTPMethod: String {
  case GET
  case POST
}
