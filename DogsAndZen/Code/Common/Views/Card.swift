//
//  Card.swift
//  DogsAndZen
//
//  Created by John Price on 4/5/24.
//

import SwiftUI

/// A styled container view used throughout the app.
struct Card<Content: View>: View {
  var alignment: Alignment = .center
  var content: () -> Content
  var body: some View {
    ZStack(alignment: alignment) {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color("theme_card"))
      ZStack(content: content)
    }
  }
}

#Preview {
  Card {
    Text("This is the card view. You can put any View you'd like in it.")
      .padding()
  }
  .padding()
  .frame(maxWidth: .infinity, maxHeight: 400)
}
