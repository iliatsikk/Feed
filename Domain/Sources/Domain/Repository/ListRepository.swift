//
//  ListRepository.swift
//  Domain
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import Foundation
import Networking

public protocol ListRepositoring {
  func getListOfImages(page: Int, perPage: Int) async throws -> [ImageItem]
}

public final class ListRepository: ListRepositoring {
  private let apiClient: APIClient

  public init(apiClient: APIClient) {
    self.apiClient = apiClient
  }

  public func getListOfImages(page: Int, perPage: Int) async throws -> [ImageItem] {
    try await apiClient.request(ListService.listImages(page: page, perPage: perPage))
  }
}
