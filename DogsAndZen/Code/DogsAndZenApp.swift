//
//  DogsAndZenApp.swift
//  DogsAndZen
//
//  Created by John Price on 4/4/24.
//

import SwiftData
import SwiftUI

@main
struct DogsAndZenApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: [
          Meditation.self,
          MeditationSession.self,
        ])
    }
  }
}
