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

struct IconGradientView: View {
  private static let gradientColors = [
    Color(red: 0.49, green: 0.11, blue: 0.83),  // purple
    Color(red: 0.90, green: 0.12, blue: 0.31),  // red
    Color(red: 0.97, green: 0.50, blue: 0.08)   // orange
  ]

  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: Self.gradientColors),
      startPoint: .top,
      endPoint: .bottom
    )
  }
}
