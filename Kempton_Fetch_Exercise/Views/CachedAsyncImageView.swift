//
//  CachedAsyncImageView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct CachedAsyncImageView<Content: View>: View {
  @EnvironmentObject private var diskImageCacheManager: DiskImageCacheManager
  private let url: URL?
  private let scale: CGFloat
  private let transaction: Transaction
  private let content: (AsyncImagePhase) -> Content
  
  init(url: URL?,
       scale: CGFloat = 1.0,
       transaction: Transaction = Transaction(),
       @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
    self.url = url
    self.scale = scale
    self.transaction = transaction
    self.content = content
  }
  
  var body: some View {
    if let url {
      if let diskImage = diskImageCacheManager.load(for: url) {
        let swiftUIImage = Image(uiImage: diskImage)
        // let _ = print("using cached image \(url)")
        content(.success(swiftUIImage))
      } else {
        AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
          // let _ = print("using AsyncImage to download \(url)")
          cacheAndRender(phase: phase)
        }
      }
    } else {
      content(.empty)
    }
  }
  
  private func cacheAndRender(phase: AsyncImagePhase) -> some View {
    if case .success(let image) = phase, let url = url {
      let uiImage: UIImage = image.render(scale: 1.0)!
      
      // used to observe images being saved to the cache in the simulator
      let filePath = diskImageCacheManager.fileURL(for: url).path
      // print("url saved \(url)")
      print("📂 Saved image at: \(filePath)")
      
      // Save UIImage to disk cache
      Task {
        await diskImageCacheManager.save(image: uiImage, for: url)
      }
      return content(.success(image))
    }
    
    return content(phase)
  }
}


#Preview {
  VStack {
    // working url
    CachedAsyncImageView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")!) { phase in
      switch phase {
      case .empty:
        ProgressView()
      case .success(let image):
        image
          .resizable()
          .frame(width: 100, height: 100)
      case .failure:
        ImageLoadingFailureView(size: CGSize(width: 50, height: 50))
      @unknown default:
        fatalError()
      }
    }
    // broken url
    CachedAsyncImageView(url: URL(string: "brokenLink")!) { phase in
      switch phase {
      case .empty:
        ProgressView()
      case .success(let image):
        image
          .resizable()
          .frame(width: 100, height: 100)
      case .failure:
        ImageLoadingFailureView(size: CGSize(width: 50, height: 50))
      @unknown default:
        fatalError()
      }
    }
    .frame(width: 100, height: 100)
  }
  .environmentObject(DiskImageCacheManager())
}
