//
//  MeditationScreen.swift
//  DogsAndZen
//
//  Created by John Price on 4/5/24.
//

import SwiftUI

/// Displays an ongoing meditation and a message when it is completed.
struct MeditationScreen: View {
  @Binding var path: NavigationPath
  @Environment(\.modelContext) private var context
  @StateObject var player = MeditationPlayer()
  @Binding var settings: MeditationSettings
  @State private var scale = 1.0

  var body: some View {
    VStack {
      if player.isFinished {
        Spacer()
        Text("Great job! 🎉")
          .font(.largeTitle)
          .fontWeight(.ultraLight)
          .foregroundStyle(.white)
          .padding()
        Text("You took time for yourself to be mindful today.")
          .font(.title2)
          .fontWeight(.light)
          .multilineTextAlignment(.center)
          .foregroundStyle(.white)
          .padding()
        ShareLink(item: URL(string: "https://dogsandzen.com")!) {
          Label("", systemImage: "square.and.arrow.up")
            .font(.title)
        }
        Spacer()
        HStack {
          Button {
            path = NavigationPath()
          } label: {
            Text("Complete").foregroundStyle(.white)
          }.buttonStyle(DZButton()).padding()
        }
      } else {
        Spacer()
        ZStack {
          Circle()
            .stroke(.white, lineWidth: 10)
            .frame(width: 300)
            .scaleEffect(player.isPlaying ? 0.7 : 1)
            .animation(
              player.isPlaying
                ? .easeInOut(duration: 3).repeatForever(autoreverses: true) : .default,
              value: player.isPlaying)
          Text(
            "\(player.remaining < 0 ? prettifyCountdown(remaining: settings.duration) : prettifyCountdown(remaining: player.remaining))"
          )
          .font(.largeTitle)
          .fontWeight(.light)
          .foregroundStyle(.white)
        }

        Spacer()
        HStack {
          Button {
            if !player.isPlaying {
              player.play(settings: settings)
            } else {
              player.pause()
            }
          } label: {
            Image(systemName: player.isPlaying ? "pause" : "play.fill")
              .font(.title)
              .foregroundStyle(.white)
          }.foregroundStyle(.black).padding()

          Button {
            player.stop()
          } label: {
            Image(systemName: "stop.fill")
              .font(.title)
              .foregroundStyle(.white)
          }.foregroundStyle(.black).padding()
        }.padding(.top)
      }
    }

    .onChange(of: player.isFinished) {
      if player.remaining < 0 {
        path = NavigationPath()
      } else {
        let session = MeditationSession(
          meditation: Meditation.timed, date: .now,
          duration: settings.duration - player.remaining)
        context.insert(session)
        do {
          try context.save()
        } catch {
          print("Unable to save meditation session: \(error)")
        }
      }
    }
    .background(
      Image("dog_7").resizable().ignoresSafeArea().scaledToFill().overlay(.black.opacity(0.8))
    )
  }
}

#Preview {
  struct Preview: View {
    @State var path = NavigationPath()
    @State var settings = MeditationSettings()
    var body: some View {
      MeditationScreen(path: $path, settings: $settings)
    }
  }

  return Preview()
}
