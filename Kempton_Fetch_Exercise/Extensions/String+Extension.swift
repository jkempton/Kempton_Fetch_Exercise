//
//  String+Extension.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import Foundation
import CryptoKit

extension String {
  func sha256() -> String {
    let inputData = Data(self.utf8)
    let hashedData = SHA256.hash(data: inputData)
    return hashedData.compactMap { String(format: "%02x", $0) }.joined()
  }
}
