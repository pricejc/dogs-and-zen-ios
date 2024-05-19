//
//  ProfileScreen.swift
//  DogsAndZen
//
//  Created by John Price on 5/19/24.
//

import SwiftUI

struct ProfileScreen: View {
  @State var dailyMeditationGoal = 10 * 60

  var body: some View {
    VStack {
      List {
        HStack {
          Text("Daily Meditation Goal")
          Picker("", selection: $dailyMeditationGoal) {
            ForEach(5..<60, id: \.self) { i in
              Text("\(i) minutes").tag(i * 60)
            }
          }
        }
      }
    }
    .navigationTitle("Account")
    .onChange(of: dailyMeditationGoal) {
      ProfileManager().DailyMeditationGoal = dailyMeditationGoal
    }
    .onAppear {
      dailyMeditationGoal = ProfileManager().DailyMeditationGoal
    }
  }
}

#Preview {
  ProfileScreen()
}
