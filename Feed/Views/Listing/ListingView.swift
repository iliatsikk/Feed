//
//  ListingView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import SwiftUI
import DesignSystem
import Kingfisher

import SwiftUI

struct ListingView: View {
  @State var viewModel: ListingConfiguration

  @State private var isShowingFullScreen = false

  private let columns = [
    GridItem(.flexible(), spacing: 16.0.scaled),
    GridItem(.flexible(), spacing: 16.0.scaled)
  ]

  var body: some View {
    ZStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 16.0.scaled) {
          ForEach(viewModel.images, id: \.self) { image in
            Button {
              viewModel.viewState.setSelectedURL(image.url)
              withAnimation {
                isShowingFullScreen = true
              }
            } label: {
              ListingItemView(url: image.url)
            }
            .buttonStyle(.plain)
          }
        }
        .padding(.horizontal, 16.0.scaled)
        .padding(.vertical, 50.0.scaled)
      }
      .task { @MainActor in await viewModel.getImages() }

      if isShowingFullScreen, let url = viewModel.viewState.selectedURL {
        FullscreenImageView(isPresented: $isShowingFullScreen, url: url)
          .transition(.opacity)
          .animation(.easeInOut(duration: 0.25), value: isShowingFullScreen)
          .zIndex(1)
      }
    }
    .animation(.easeInOut, value: isShowingFullScreen)
  }
}

struct FullscreenImageView: View {
  @Binding var isPresented: Bool
  let url: URL

  var body: some View {
    ZStack(alignment: .topTrailing) {
      Color.black.ignoresSafeArea()

      KFImage(url)
        .resizable()
        .scaledToFill()
        .frame(
          minWidth: .zero, maxWidth: .infinity,
          minHeight: .zero, maxHeight: .infinity
        )

      Button(action: {
        isPresented = false
      }) {
        Image(systemName: "xmark.circle.fill")
          .font(.system(size: 32, weight: .bold))
          .foregroundColor(.white)
          .padding()
      }
    }
  }
}
