//
//  MeditationCard.swift
//  DogsAndZen
//
//  Created by John Price on 4/12/24.
//

import SwiftUI

/// Displays the users progress towards their daily
/// meditation goal.
struct MeditationCard: View {
  var progress: Double

  var body: some View {
    Card(alignment: .leading) {
      HStack(alignment: .center) {
        ZStack {
          Circle()
            .stroke(Color(.gray).opacity(0.5), lineWidth: 10)
            .frame(width: 70)
          Circle()
            .trim(from: 0, to: progress)
            .stroke(
              Color("theme_primary"),
              style: StrokeStyle(
                lineWidth: 10,
                lineCap: .round
              )
            )
            .frame(width: 70)
            .rotationEffect(.degrees(-90))
          if progress >= 1 {
            Image(systemName: "checkmark")
              .font(.title)
              .fontWeight(.bold)
              .foregroundStyle(Color("theme_primary"))
          }
        }
        .padding()
        VStack(alignment: .leading) {
          Text("Daily Meditation")
            .font(.title)
            .foregroundStyle(.foreground)
          Text("Timed Meditation")
            .foregroundStyle(Color("theme_caption"))
        }
      }
    }
  }
}

#Preview {
  MeditationCard(progress: 1)
}
