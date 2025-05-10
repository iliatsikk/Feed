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

  func getImages() async {
    do {
      let data = try await repository.getListOfImages(page: 1, perPage: 20)
      viewState.images.append(contentsOf: data)
    } catch {
      print(error)
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

    var image = viewState.images[index + 1]

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

    var image = viewState.images[index - 1]

    viewState.setSelectedURL(image.url, id: image.id)
  }
}
