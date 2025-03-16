//
//  MockDiskImageCacheManager.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/15/25.
//

import SwiftUI

class MockDiskImageCacheManager: DiskImageCacheManagerProtocol {
  
  // Simulate a cached image dictionary
  private var imageCache = [URL: UIImage]()
  
  func fileURL(for url: URL) -> URL {
    return URL(string: "mock://path/to/\(url.lastPathComponent)")!
  }
  
  func save(image: UIImage, for url: URL) async {
    imageCache[url] = image
    print("Mock save image: \(url)")
  }
  
  func load(for url: URL) -> UIImage? {
    return imageCache[url]
  }
  
}
