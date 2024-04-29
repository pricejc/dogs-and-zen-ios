//
//  PreMeditationScreen.swift
//  DogsAndZen
//
//  Created by John Price on 4/23/24.
//

import SwiftUI

struct MeditationSettings {
  var duration = 10 * 60
  var chimeInterval = 0
  var playGong = true
}

/// Displays the setup for a meditation session.
struct MeditationSetupScreen: View {
  @Binding var path: NavigationPath

  @Binding var settings: MeditationSettings

  var body: some View {
    VStack {
      Text("Timed Meditation")
        .font(.largeTitle)
        .fontWeight(.ultraLight)
        .foregroundStyle(.white)
      Spacer()
      LabeledContent {
        Picker("Duration", selection: $settings.duration) {
          ForEach([20, 300, 600, 1800], id: \.self) { duration in
            Text(getDurationLabel(duration)).tag(duration)
          }
        }
      } label: {
        Label("Duration", systemImage: "")
      }
      .foregroundStyle(.white)
      LabeledContent {
        Picker("Chime Interval", selection: $settings.chimeInterval) {
          ForEach([0, 10, 60, 180, 300], id: \.self) { interval in
            Text(getChimeIntervalLabel(interval)).tag(interval)
          }
        }
      } label: {
        Label("Chime Interval", systemImage: "")
      }
      .foregroundStyle(.white)
      Toggle(isOn: $settings.playGong) {
        Label("Gong", systemImage: "")
      }
      .foregroundStyle(.white)
      Spacer()
      NavigationLink(value: "Meditation") {
        Text("Begin Meditation")
      }.buttonStyle(DZButton()).padding()
        .foregroundStyle(.white)
    }
    .padding()
    .background(
      Image("dog_7").resizable().ignoresSafeArea().scaledToFill().overlay(.black.opacity(0.8))
    )
  }

  func getDurationLabel(_ duration: Int) -> String {
    if duration == 20 {
      return "(DEBUG) 20 seconds"
    }

    return "\(duration / 60) minutes"
  }

  func getChimeIntervalLabel(_ interval: Int) -> String {
    if interval == 0 {
      return "Off"
    }

    if interval == 10 {
      return "(DEBUG) 10 seconds"
    }

    return "Every \(interval / 60) minutes"
  }
}

#Preview {
  struct Preview: View {
    @State var path = NavigationPath()
    @State var settings = MeditationSettings()
    var body: some View {
      MeditationSetupScreen(path: $path, settings: $settings)
    }
  }

  return Preview()
}
