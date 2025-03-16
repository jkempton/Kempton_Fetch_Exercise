//
//  DiskImageCacheManager.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import Foundation
import SwiftUI

protocol DiskImageCacheManagerProtocol {
  func fileURL(for url: URL) -> URL
  func save(image: UIImage, for url: URL) async
  func load(for url: URL) -> UIImage?
}

class DiskImageCacheManager: NSObject, ObservableObject, DiskImageCacheManagerProtocol {
  private let fileManager = FileManager.default
  private let cacheDirectory: URL
  
  override init() {
    cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    super.init()
  }
  
  // Generate file path for a given URL
  func fileURL(for url: URL) -> URL {
    let hashedFilename = url.absoluteString.sha256() + ".png"
    return cacheDirectory.appendingPathComponent(hashedFilename)
  }
  
  // Save image to disk asynchronously
  func save(image: UIImage, for url: URL) async {
    let fileURL = fileURL(for: url)
    guard let data = image.pngData() else { return }
    
    do {
      try await Task.detached(priority: .utility) {
        try data.write(to: fileURL)
      }.value  // Wait for the task to complete
    } catch {
      print("Failed to save image to disk: \(error)")
    }
  }
  
  // Load image from disk
  func load(for url: URL) -> UIImage? {
    let fileURL = fileURL(for: url)
    if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
      print("load cached imag \(url)")
      return image
    }
    return nil
  }
}
