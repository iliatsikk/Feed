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

  let itemsFromEndThreshold: Int = 10
  var currentPage: Int = 1
  var hasNextPage: Bool = true
  var paginationIsLoading: Bool = false

  var state: ViewState
  var selectedItem: ListingConfiguration.DataItem?
  var images: [ListingConfiguration.DataItem]

  init(state: ViewState) {
    self.images = []
    self.state = state
  }

  // MARK: - Setters

  func setSelectedItem(_ item: ListingConfiguration.DataItem?, id: String) {
    selectedItem = item
    setIsSeen(true, id: id)
  }

  func setIsSeen(_ isSeen: Bool, id: String) {
    images = images.map {
      guard $0.id == id else { return $0 }

      var item = $0
      item.seen = true
      return item
    }
  }
}
