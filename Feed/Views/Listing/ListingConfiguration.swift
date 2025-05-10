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

  var images: [DataItem] = []

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
      images.append(contentsOf: data)
    } catch {
      print(error)
    }
  }
}
