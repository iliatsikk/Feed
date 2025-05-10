//
//  ListingViewState.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation

@MainActor
@Observable
final class ListingViewState: NSObject, Sendable {
  @MainActor
  enum ViewState: Sendable {
    case regular
    case loading
    case empty
    case error
  }

  var state: ViewState
  var selectedURL: URL?

  init(state: ViewState) {
    self.state = state
  }

  // MARK: - Setters

  func setSelectedURL(_ url: URL?) {
    selectedURL = url
  }
}
