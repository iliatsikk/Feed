//
//  File.swift
//  DesignSystem
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import UIKit

public struct Constants {
  public struct Screen {
    @MainActor public static let width = UIScreen.main.bounds.width
    @MainActor public static let height = UIScreen.main.bounds.height
    @MainActor public static let factor = Constants.Screen.width / 440.0
  }
}
