//
//  ListingView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import SwiftUI
import DesignSystem

struct ListingView: View {
  @State var viewModel: ListingConfiguration

  private let columns = [
    GridItem(.flexible(), spacing: 16.0.scaled),
    GridItem(.flexible(), spacing: 16.0.scaled)
  ]

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 16.0.scaled) {
        getItems()
      }
      .padding(.horizontal, 16.0.scaled)
      .padding(.vertical, 50.0.scaled)
    }
    .task { @MainActor in
      await viewModel.getImages()
    }
  }

  @ViewBuilder
  private func getItems() -> some View {
    ForEach(viewModel.images, id: \.self) { image in
      ListingItemView(url: image.url)
    }
  }
}

#Preview {
  ListingView(viewModel: .init())
}
