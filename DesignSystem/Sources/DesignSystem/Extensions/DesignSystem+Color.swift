//
//  DesignSystem+Color.swift
//  DesignSystem
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI

public extension Color {
  enum System {
    /// Folder name in assets catalogue
    private static let namespace = "Colors"

    public static let background: Color = Color("\(namespace)/background", bundle: .module)

    public static let darkBackground: Color = Color("\(namespace)/dark-background", bundle: .module)
  }
}
