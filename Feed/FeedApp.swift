//
//  FeedApp.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI

@main
struct FeedApp: App {
  var body: some Scene {
    WindowGroup {
      ListingView(viewModel: .init())
    }
  }
}
