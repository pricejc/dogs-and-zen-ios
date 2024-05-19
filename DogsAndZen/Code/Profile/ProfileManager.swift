//
//  ProfileManager.swift
//  DogsAndZen
//
//  Created by John Price on 5/19/24.
//

import Foundation

class ProfileManager {
  private let defaults = UserDefaults.standard

  var DailyMeditationGoal: Int {
    get { return defaults.value(forKey: "DailyMeditationGoal") as? Int ?? 10 * 60 }
    set { defaults.set(newValue, forKey: "DailyMeditationGoal") }
  }
}
