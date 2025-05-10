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

  var body: some View {
    KFImage(url)
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
  }
}
