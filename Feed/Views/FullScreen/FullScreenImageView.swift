//
//  FullScreenImageView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI
import Kingfisher

struct FullscreenImageView: View {
  @Binding var isPresented: Bool

  let showNext: () -> Void
  let showPrevious: () -> Void
  let url: URL

  var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .topTrailing) {
        Color.black.ignoresSafeArea()

        KFImage(url)
          .resizable()
          .scaledToFill()
          .frame(
            maxWidth: proxy.size.width,
            maxHeight: proxy.size.height
          )

        Button {
          isPresented = false
        } label: {
          Image(systemName: "xmark.circle.fill")
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.white)
            .padding()
        }
      }

      HStack(spacing: .zero) {
        Color.clear
          .contentShape(.rect)
          .onTapGesture {
            showPrevious()
          }

        Color.clear
          .contentShape(.rect)
          .onTapGesture {
            showNext()
          }
      }
    }
  }
}
