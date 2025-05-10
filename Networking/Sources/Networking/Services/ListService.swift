//
//  ListService.swift
//  Networking
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation
import Alamofire

public enum ListService {
  case listImages(page: Int, perPage: Int)
}

extension ListService: APIService {
  public var path: String {
    switch self {
    case .listImages: "/list"
    }
  }

  public var method: HTTPMethod {
    return .get
  }

  public var queryParameters: Parameters? {
    switch self {
    case .listImages(let page, let perPage):
      return ["page": page, "limit": perPage]
    }
  }
}
