//
//  UserRepository.swift
//  Domain
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import Networking

public protocol UserRepositoring: Sendable {
  func getUsers() async throws -> [UserItem]
}

public final class UserRepository: UserRepositoring {
  private let apiClient: APIClient

  public init(apiClient: APIClient) {
    self.apiClient = apiClient
  }

  public func getUsers() async throws -> [UserItem] {
    guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
      throw NSError(domain: "File not found", code: -1, userInfo: nil)
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()

    return try decoder.decode([UserItem].self, from: data)
  }
}
