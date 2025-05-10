//
//  ListingView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import SwiftUI
import Domain
import Networking

struct ListingView: View {
  @State var viewModel: ListingConfiguration

  var body: some View {
    VStack(spacing: .zero) {
    }
    .task { @MainActor in
      await viewModel.getImages()
    }
  }
}

#Preview {
  ListingView(viewModel: .init())
}
