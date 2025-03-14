//
//  ImageLoadingFailureView.swift
//  Kempton_Fetch_Exercise
//
//  Created by Justin Kempton on 3/14/25.
//

import SwiftUI

struct ImageLoadingFailureView: View {
  let size: CGSize
  var body: some View {
    Rectangle()
      .fill(.clear)
      .aspectRatio(1, contentMode: .fit)
      .overlay(
        Image(systemName: "exclamationmark.triangle.fill")
          .resizable()
          .foregroundColor(.red)
          .frame(width: size.width, height: size.height)
      )
  }
}


#Preview {
  // 50x50 and 100x100 sizes
  VStack {
    ImageLoadingFailureView(size: CGSize(width: 50, height: 50))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 1)
      )
    ImageLoadingFailureView(size: CGSize(width: 100, height: 100))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 1)
      )
  }
}
