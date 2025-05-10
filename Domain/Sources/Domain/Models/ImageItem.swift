//
//  ImageItem.swift
//  Domain
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation

public struct ImageItem: Codable, Identifiable {
  public let id: String
  public let width: Int
  public let height: Int
  public let urlString: String
  public let author: String
  public let downloadURL: String

  public var url: URL? {
    return URL(string: downloadURL)
  }

  public var seen: Bool = false
  public var user: UserItem?
  public var isLiked: Bool = false

  enum CodingKeys: String, CodingKey {
    case id, width, height, author
    case urlString = "url"
    case downloadURL = "download_url"
  }
}

extension ImageItem: Equatable {}
extension ImageItem: Sendable {}
extension ImageItem: Hashable {}
