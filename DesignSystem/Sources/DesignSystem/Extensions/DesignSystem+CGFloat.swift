//
//  File.swift
//  DesignSystem
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import UIKit

public extension CGFloat {
  /// Add width scale factor to self
  @MainActor var scaled: CGFloat {
    (self * Constants.Screen.factor).rounded(.toNearestOrAwayFromZero)
  }
}

public extension Double {
  @MainActor var scaled: CGFloat {
    (self * Constants.Screen.factor).rounded(.toNearestOrAwayFromZero)
  }
}
