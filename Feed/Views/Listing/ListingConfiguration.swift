//
//  ListingConfiguration.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import Domain
import Networking

@MainActor
@Observable
final class ListingConfiguration: NSObject, Sendable {
  typealias DataItem = ImageItem

  var viewState: ListingViewState

  private let repository: ListRepositoring
  private let apiClient = APIClient() // TODO: Create DI

  // MARK: - Lifecycle

  override init() {
    self.viewState = .init(state: .loading)
    self.repository = ListRepository(apiClient: apiClient)
  }

  deinit {
    print("deinit \(String(describing: type(of: self)))")
  }

  // MARK: - Inputs

  func requestMoreItemsIfNeeded(index: Int) async {
    guard viewState.hasNextPage else {
      return
    }

    if thresholdMeet(viewState.images.count + 1, index) {
      await loadMoreImages()
    }
  }

  /// Determines whether we have met the threshold for requesting more items.
  private func thresholdMeet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
    return (itemsLoadedCount - index) <= viewState.itemsFromEndThreshold && !viewState.paginationIsLoading
  }

  func loadMoreImages() async {
    viewState.paginationIsLoading = true

    defer {
      viewState.paginationIsLoading = false
    }

    do {
      let data = try await repository.getListOfImages(page: viewState.currentPage, perPage: viewState.itemsFromEndThreshold * 2)

      await MainActor.run {
        viewState.images.append(contentsOf: data)
        viewState.currentPage += 1
        viewState.hasNextPage = !data.isEmpty
      }
    } catch {
      dump(error)
    }
  }

  /// Show the next image in the list
  func showNextImage() {
    guard let current = viewState.selectedURL else {
      return
    }

    guard let index = viewState.images.firstIndex(where: { $0.url == current }), index + 1 < viewState.images.count else {
      return
    }

    let image = viewState.images[index + 1]

    viewState.setSelectedURL(image.url, id: image.id)
  }

  /// Show the previous image in the list
  func showPreviousImage() {
    guard let current = viewState.selectedURL else {
      return
    }

    guard let index = viewState.images.firstIndex(where: { $0.url == current }), index > 0 else {
      return
    }

    let image = viewState.images[index - 1]

    viewState.setSelectedURL(image.url, id: image.id)
  }
}
