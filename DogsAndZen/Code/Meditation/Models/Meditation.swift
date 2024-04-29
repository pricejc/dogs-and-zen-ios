//
//  Meditation.swift
//  DogsAndZen
//
//  Created by John Price on 4/12/24.
//

import Foundation
import SwiftData

/// Contains information about a meditation available to users.
@Model
class Meditation: Codable {
  enum CodingKeys: CodingKey {
    case id, name
  }

  var id: UUID
  var name: String
  var sessions: [MeditationSession]

  init(id: UUID = UUID(), name: String, sessions: [MeditationSession] = []) {
    self.id = id
    self.name = name
    self.sessions = sessions
  }

  required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(UUID.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    sessions = []
  }

  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
  }

  static let timed: Meditation = Meditation(
    id: UUID(uuidString: "b06b1175-5506-4744-8b46-bc63096924ac")!, name: "Timed Meditation",
    sessions: [])
}
