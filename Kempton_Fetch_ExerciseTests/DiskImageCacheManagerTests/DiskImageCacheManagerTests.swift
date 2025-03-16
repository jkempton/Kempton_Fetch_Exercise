//
//  DiskImageCacheManagerTests.swift
//  Kempton_Fetch_ExerciseTests
//
//  Created by Justin Kempton on 3/15/25.
//

import XCTest
import Kempton_Fetch_Exercise

final class DiskImageCacheManagerTests: XCTestCase {
  
  var cacheManager: MockDiskImageCacheManager!
  
  override func setUp() {
    super.setUp()
    cacheManager = MockDiskImageCacheManager()
  }
  
  override func tearDown() {
    super.tearDown()
    cacheManager = nil
  }
  
  func testSaveAndLoadImage() async {
    // Ensure the system image exists
    guard let testImage = UIImage(systemName: "star") else {
      XCTFail("Failed to create image")
      return
    }
    
    let testURL = URL(string: "https://example.com/image.png")!
    
    // Simulate saving the image
    await cacheManager.save(image: testImage, for: testURL)
    
    // Simulate loading the image
    if let loadedImage = cacheManager.load(for: testURL) {
      XCTAssertNotNil(loadedImage)
      XCTAssertEqual(loadedImage.pngData(), testImage.pngData())  // Compare image data
    } else {
      XCTFail("Image should have been loaded successfully")
    }
  }
  
}
