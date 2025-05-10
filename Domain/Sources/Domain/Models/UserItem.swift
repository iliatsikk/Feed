//
//  UserItem.swift
//  Domain
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import Foundation

public struct UserItem: Codable {
  public let id: Int
  public let name: String
  public let profilePictureURLString: String

  public var profileURL: URL? {
    URL(string: profilePictureURLString)
  }

  public var seen: Bool = false

  enum CodingKeys: String, CodingKey {
    case id, name
    case profilePictureURLString = "profile_picture_url"
  }
}

extension UserItem: Equatable {}
extension UserItem: Sendable {}
extension UserItem: Hashable {}
