//
//  APIRequestInterceptor.swift
//  Networking
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import Alamofire

final class APIRequestInterceptor: RequestInterceptor {
  func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @Sendable @escaping (Result<URLRequest, Error>) -> Void
  ) {
    var request = urlRequest

  // TODO: Add headers
//    request.headers.add(name: "Accept", value: "application/vnd.github+json")
//    request.headers.add(name: "X-GitHub-Api-Version", value: APIConfig.apiVersion)

    completion(.success(request))
  }
}
