//
//  AlertManager.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/15/25.
//

import Foundation

class AlertManager: NSObject, ObservableObject {
  @Published var alertError: AlertError?
}
