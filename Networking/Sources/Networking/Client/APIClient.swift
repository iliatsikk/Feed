//
//  APIClient.swift
//  Networking
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import Alamofire

public enum APIConfig {
  public static let baseURL = "https://picsum.photos/v2"
}

public final class APIClient: @unchecked Sendable {
  private let session: Session

  public init() {
    let logger = NetworkLogger()

    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 60

    session = Session(
      configuration: configuration,
      eventMonitors: [logger]
    )
  }

  public func request<T: Decodable & Sendable>(_ service: some APIService) async throws -> T {
    do {
      let response = try await session
        .request(service)
        .validate(statusCode: 200..<300)
        .serializingDecodable(T.self)
        .value
      return response
    } catch {
      throw error
    }
  }
}
