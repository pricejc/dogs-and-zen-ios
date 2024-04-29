//
//  HomeScreen.swift
//  DogsAndZen
//
//  Created by John Price on 4/5/24.
//

import SwiftData
import SwiftUI

/// The Home screen.
struct HomeScreen: View {
  @Environment(\.modelContext) private var context

  @Query(
    filter: MeditationSession.inRange(
      startDate: Date().startOfMonth(), endDate: Date().endOfMonth()))
  private var sessions: [MeditationSession]
  private var dogQuote = getRandomDogQuote()
  private var dogQuotes = getDogQuotes()
  private var dailyProgress: Double = 0.0

  @State private var path = NavigationPath()
  @State private var meditationSettings = MeditationSettings()

  var body: some View {
    NavigationStack(path: $path) {
      ZStack(alignment: .top) {
        Rectangle()
          .fill(Color("theme_primary"))
          .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity /*@END_MENU_TOKEN@*/, maxHeight: 300)
          .ignoresSafeArea()
        VStack {
          HStack {
            Image("logo_white")
              .resizable()
              .frame(width: 48, height: 48)
              .padding(.leading)
            Text("Dogs & Zen")
              .font(.title)
              .foregroundStyle(.white)
              .fontWeight(.light)
            Spacer()
          }
          ScrollView {
            VStack {
              DogQuoteCard(dog: dogQuote.0, quote: dogQuote.1).padding([
                .leading, .trailing, .bottom,
              ])
              NavigationLink(value: "MeditationSetup") {
                MeditationCard(progress: getDailyProgress()).padding([.leading, .trailing, .bottom])
              }
              .buttonStyle(PlainButtonStyle())
              .navigationDestination(for: String.self) { x in
                if x == "MeditationSetup" {
                  MeditationSetupScreen(path: $path, settings: $meditationSettings)
                } else if x == "Meditation" {
                  MeditationScreen(path: $path, settings: $meditationSettings)
                }
              }
              Card {
                MeditationCalendar(sessions: Binding(get: { sessions }, set: { _ in }))
              }
              .padding([.leading, .trailing])
              .frame(height: 300)
            }
          }
        }
      }
      .background(.themeBackground)
      .navigationBarBackButtonHidden()
    }
  }

  func getDailyProgress() -> Double {
    let targetDuration = 300.0
    var duration = 0.0
    for session in sessions {
      if Calendar.current.isDateInToday(session.date) {
        duration += Double(session.duration)
      }
    }

    return duration / targetDuration
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: Meditation.self, MeditationSession.self, configurations: config)
  return HomeScreen().modelContainer(container)
}
