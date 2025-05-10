//
//  FullScreenImageView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI
import Kingfisher
import DesignSystem

struct FullscreenImageView: View {
  @Binding var isPresented: Bool

  let showNext: () -> Void
  let showPrevious: () -> Void
  let url: URL

  @GestureState private var dragOffset: CGSize = .zero

  @State private var initialY: CGFloat = .zero
  @State private var isInitial: Bool = true

  var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .topTrailing) {
        Color.black.ignoresSafeArea()

        KFImage(url)
          .setProcessor(DownsamplingImageProcessor(size: .init(width: Constants.Screen.width, height: Constants.Screen.height)))
          .cacheOriginalImage()
          .resizable()
          .scaledToFill()
          .frame(
            maxWidth: proxy.size.width,
            maxHeight: proxy.size.height
          )
          .clipped()

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
        .zIndex(1)
      }
      .offset(x: .zero, y: dragOffset.height)
      .gesture(
        DragGesture()
          .updating($dragOffset) { value, state, _ in
            if isInitial {
              initialY = value.location.y
              isInitial = false
            }
          }
          .onEnded { value in
            if initialY - value.location.y < -30.0.scaled {
              withAnimation(.linear(duration: 0.25)) {
                isPresented = false
              }
            } else {
              initialY = .zero
              isInitial = true
            }

//            if value.translation.height < 400.0.scaled {
//              withAnimation(.linear(duration: 0.25)) {
//                isPresented = false
//              }
//            } else if value.translation.width < -50 {
//              withAnimation(.easeInOut) {
//                showNext() }
//            } else if value.translation.width > 50 {
//              withAnimation(.easeInOut) { showPrevious() }
//            }
          }
      )
      .transition(.move(edge: .bottom))
    }
  }
}
