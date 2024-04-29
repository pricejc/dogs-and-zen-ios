//
//  MeditationSession.swift
//  DogsAndZen
//
//  Created by John Price on 4/10/24.
//
import Foundation
import SwiftData

/// Contains information about a session when a user meditated.
@Model
class MeditationSession: Codable {
  enum CodingKeys: CodingKey {
    case id, meditation, date, duration
  }

  var id: UUID
  var meditation: Meditation?
  var date: Date
  var duration: Int

  init(id: UUID = UUID(), meditation: Meditation?, date: Date = .now, duration: Int) {
    self.id = id
    self.meditation = meditation
    self.date = date
    self.duration = duration
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(UUID.self, forKey: .id)
    meditation = try container.decode(Meditation.self, forKey: .meditation)
    date = try container.decode(Date.self, forKey: .date)
    duration = try container.decode(Int.self, forKey: .duration)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(meditation, forKey: .meditation)
    try container.encode(date, forKey: .date)
    try container.encode(duration, forKey: .duration)
  }

  static func inRange(startDate: Date, endDate: Date) -> Predicate<MeditationSession> {
    return #Predicate<MeditationSession> { session in
      session.date > startDate && session.date < endDate
    }
  }
}
