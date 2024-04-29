//
//  DogImage.swift
//  DogsAndZen
//
//  Created by John Price on 4/10/24.
//

import Foundation

/// Contains information about a dog image.
class DogImage: Identifiable, Codable {
  var id: UUID
  var imagePath: String

  init(id: UUID = UUID(), imagePath: String) {
    self.id = id
    self.imagePath = imagePath
  }

  static let samples = [
    DogImage(imagePath: "dog_1"),
    DogImage(imagePath: "dog_2"),
    DogImage(imagePath: "dog_3"),
    DogImage(imagePath: "dog_4"),
    DogImage(imagePath: "dog_5"),
    DogImage(imagePath: "dog_6"),
  ]
}
