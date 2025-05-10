//
//  ListingItemView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI
import DesignSystem
import Kingfisher

struct ListingItemView: View {
  var url: URL?
  var isSeen: Bool
  var userProfileImage: URL?

  var body: some View {
    KFImage(url)
      .setProcessor(DownsamplingImageProcessor(size: .init(width: 200.0.scaled, height: 200.0.scaled)))
      .cacheOriginalImage()
      .cacheMemoryOnly()
      .placeholder {
        ProgressView()
      }
      .resizable()
      .scaledToFill()
      .clipShape(.circle)
      .frame(width: 160.0.scaled, height: 160.0.scaled)
      .padding(5.0.scaled)
      .background(
        IconGradientView()
          .overlay {
            if isSeen {
              Rectangle().fill(Color.gray)
            }
          }
      )
      .clipShape(.circle)
      .animation(.easeInOut(duration: 0.25), value: isSeen)
      .overlay(alignment: .bottomLeading) {
        KFImage(userProfileImage)
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
  }
}
