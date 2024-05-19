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
  @Environment(\.scenePhase) private var scenePhase

  @Query(
    filter: MeditationSession.inRange(
      startDate: Date().startOfMonth(), endDate: Date().endOfMonth()))
  private var sessions: [MeditationSession]
  @State private var dogQuote = getRandomDogQuote()
  @State private var path = NavigationPath()
  @State private var meditationSettings = MeditationSettings()
  @State private var dailyProgress = 0.0

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
            NavigationLink(destination: ProfileScreen.init) {
              Image(systemName: "person.circle.fill")
                .foregroundStyle(.white)
                .padding()
                .font(.title2)
            }
          }
          ScrollView {
            VStack {
              DogQuoteCard(dog: dogQuote.0, quote: dogQuote.1).padding([
                .leading, .trailing, .bottom,
              ])
              NavigationLink(value: "MeditationSetup") {
                MeditationCard(progress: dailyProgress).padding([.leading, .trailing, .bottom])
              }
              .onAppear {
                dailyProgress = getDailyProgress()
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
    .onChange(of: scenePhase) { oldPhase, newPhase in
      if newPhase == .active {
        dogQuote = getRandomDogQuote()
      }
    }
  }

  func getDailyProgress() -> Double {
    let targetDuration = Double(ProfileManager().DailyMeditationGoal)
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
