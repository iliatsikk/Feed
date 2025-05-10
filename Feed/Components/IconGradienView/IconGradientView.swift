//
//  IconGradientView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI

struct IconGradientView: View {
  private static let gradientColors = [
    Color(red: 0.49, green: 0.11, blue: 0.83),  // purple
    Color(red: 0.90, green: 0.12, blue: 0.31),  // red
    Color(red: 0.97, green: 0.50, blue: 0.08)   // orange
  ]

  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: Self.gradientColors),
      startPoint: .top,
      endPoint: .bottom
    )
  }
}
