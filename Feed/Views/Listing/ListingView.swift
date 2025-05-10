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

struct ListingView: View {
  @State var config: ListingConfiguration

  @State private var isShowingFullScreen = false

  private let columns = [
    GridItem(.flexible(), spacing: 16.0.scaled),
    GridItem(.flexible(), spacing: 16.0.scaled)
  ]

  var body: some View {
    ZStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 16.0.scaled) {
          ForEach(
            Array(config.viewState.images.enumerated()),
            id: \.element.id
          ) { index, image in
            Button {
              config.viewState.setSelectedItem(image, id: image.id)
              withAnimation {
                isShowingFullScreen = true
              }
            } label: {
              ListingItemView(url: image.url, isSeen: image.seen, userProfileImage: image.user?.profileURL)
                .id(image.id)
                .task { @MainActor in
                  await config.requestMoreItemsIfNeeded(index: index)
                }
            }
            .buttonStyle(.plain)
          }
        }
        .padding(.horizontal, 16.0.scaled)
        .padding(.vertical, 50.0.scaled)
      }
      .task { @MainActor in
        await config.loadMoreImages()
      }

      if isShowingFullScreen, let item = config.viewState.selectedItem {
        FullscreenImageView(
          isPresented: $isShowingFullScreen,
          showNext: config.showNextImage,
          showPrevious: config.showPreviousImage,
          onLike: {
            config.onLike(for: item.id)
          },
          url: item.url,
          profileURL: item.user?.profileURL,
          profileName: item.user?.name,
          isLiked: item.isLiked
        )
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.25), value: isShowingFullScreen)
        .zIndex(1)
      }
    }
    .background(Color.System.background)
  }
}
