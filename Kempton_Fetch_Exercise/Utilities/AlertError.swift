//
//  AlertError.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/15/25.
//

import Foundation

enum AlertError: LocalizedError, Identifiable, Equatable {
  var id: String { errorDescription ?? UUID().uuidString }
  
  case badServerResponse
  case unknownError
  case customError(title: String, subTitle: String)
  
  // User-friendly description for each error, add more as we scale
  var errorDescription: String {
    switch self {
    case .badServerResponse:
      return "Server Response Error: We received an unexpected response from the server. Please try again later."
    case .unknownError:
      return "An unknown error occurred. Please try again."
    case .customError(_, let message):
      return message // Custom error with a specific message
    }
  }
  
  var errorTitle: String {
    switch self {
    case .badServerResponse: return "Bad Server Response"
    case .unknownError: return "Unknown Error"
    case .customError(let title, _): return title
    }
  }
  
  var localizedDescription: String {
    return errorDescription
  }
}
