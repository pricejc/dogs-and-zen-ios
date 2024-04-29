//
//  DZButton.swift
//  DogsAndZen
//
//  Created by John Price on 4/24/24.
//

import SwiftUI

/// A custom button style for the app.
struct DZButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(Color("theme_primary"))
      .foregroundStyle(.white)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .scaleEffect(configuration.isPressed ? 1.2 : 1)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}

#Preview {
  struct Preview: View {
    var body: some View {
      Button("Press Me") {
        print("boop")
      }
      .buttonStyle(DZButton())
    }
  }

  return Preview()
}
