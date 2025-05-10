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

  private let listRepository: ListRepositoring
  private let userRepository: UserRepositoring

  private let apiClient = APIClient() // TODO: Create DI

  // MARK: - Lifecycle

  override init() {
    self.viewState = .init(state: .loading)
    self.listRepository = ListRepository(apiClient: apiClient)
    self.userRepository = UserRepository(apiClient: apiClient)
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
      let data = try await listRepository.getListOfImages(page: viewState.currentPage, perPage: viewState.itemsFromEndThreshold * 2)

      let users = try await userRepository.getUsers()

      await MainActor.run {
        var data = data
        data = data.map { imageItem in
          var item = imageItem
          item.user = users.randomElement()
          return item
        }

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
    guard let current = viewState.selectedItem?.url else {
      return
    }

    guard let index = viewState.images.firstIndex(where: { $0.url == current }), index + 1 < viewState.images.count else {
      return
    }

    let image = viewState.images[index + 1]

    viewState.setSelectedItem(image, id: image.id)
  }

  /// Show the previous image in the list
  func showPreviousImage() {
    guard let current = viewState.selectedItem?.url else {
      return
    }

    guard let index = viewState.images.firstIndex(where: { $0.url == current }), index > 0 else {
      return
    }

    let image = viewState.images[index - 1]

    viewState.setSelectedItem(image, id: image.id)
  }

  func onLike(for imageId: String) {
    guard let index = viewState.images.firstIndex(where: { $0.id == imageId }) else {
      return
    }

    viewState.selectedItem?.isLiked.toggle()
    viewState.images[index].isLiked.toggle()
  }
}
