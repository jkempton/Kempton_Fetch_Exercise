//
//  View+Extension.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

extension View {
  func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
    ZStack(alignment: alignment) {
      placeholder().opacity(shouldShow ? 1 : 0)
      self
    }
  }
  
  //https://stackoverflow.com/a/77245584
  //In SwiftUI, you can't directly convert an Image to a UIImage, which is needed for saving images to disk.
  //This render() extension uses ImageRenderer to capture the SwiftUI view as a UIImage, allowing us to store
  //it in a disk cache. The @MainActor annotation ensures that rendering happens on the main thread
  //since UI operations must run there.
  /// Usually you would pass  `@Environment(\.displayScale) var displayScale`
  @MainActor func render(scale displayScale: CGFloat = 1.0) -> UIImage? {
    let renderer = ImageRenderer(content: self)
    renderer.scale = displayScale
    return renderer.uiImage
  }
}
