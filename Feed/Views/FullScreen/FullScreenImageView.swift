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
  let onLike: () -> Void

  let url: URL?

  let profileURL: URL?
  let profileName: String?

  let isLiked: Bool

  @GestureState private var dragOffset: CGSize = .zero

  @State private var initialY: CGFloat = .zero
  @State private var isInitial: Bool = true

  var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .topLeading) {
        Color.System.darkBackground.ignoresSafeArea()

        KFImage(url)
          .setProcessor(DownsamplingImageProcessor(size: .init(width: Constants.Screen.width, height: Constants.Screen.height)))
          .cacheOriginalImage()
          .resizable()
          .scaledToFit()
          .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
          )
          .clipped()

        HStack(spacing: 16.0.scaled) {
          if let profileURL {
            KFImage(profileURL)
              .setProcessor(DownsamplingImageProcessor(size: .init(width: 200.0.scaled, height: 200.0.scaled)))
              .placeholder {
                ProgressView()
              }
              .resizable()
              .scaledToFill()
              .clipShape(.circle)
              .frame(width: 34.0.scaled, height: 34.0.scaled)
              .padding(2.0.scaled)
              .background(Color.secondary)
              .clipShape(.circle)
          }

          if let profileName {
            Text(profileName)
              .font(.system(size: 12))
              .foregroundStyle(.white)
          }
        }
        .padding(.top, 72.0.scaled)
        .padding(.leading, 16.0.scaled)

        HStack(spacing: .zero) {
          Color.clear
            .contentShape(.rect)
            .onTapGesture {
              withAnimation(.linear(duration: 0.25)) {
                showPrevious()
              }
            }

          Color.clear
            .contentShape(.rect)
            .onTapGesture {
              withAnimation(.linear(duration: 0.25)) {
                showNext()
              }
            }
        }
        .zIndex(1)

        HStack(spacing: .zero) {
          Spacer()

          Button {
            onLike()
          } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
              .symbolRenderingMode(.hierarchical)
              .foregroundStyle(isLiked ? .red : .white)
              .font(.system(size: 34))
          }
          .padding(.top, 620.0.scaled)
          .padding(.trailing, 16.0.scaled)
        }
        .zIndex(2)
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

            if value.translation.width < -50 {
              withAnimation(.linear(duration: 0.25)) {
                showNext()
              }
            } else if value.translation.width > 50 {
              withAnimation(.linear(duration: 0.25)) {
                showPrevious()
              }
            }
          }
      )
      .transition(.move(edge: .bottom))
    }
  }
}
