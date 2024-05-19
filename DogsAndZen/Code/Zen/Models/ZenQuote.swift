//
//  ZenQuote.swift
//  DogsAndZen
//
//  Created by John Price on 4/23/24.
//

import Foundation

/// Represents a zen quote and the author that said it.
class ZenQuote: Identifiable, Codable {
  var id: UUID
  var quote: String
  var author: String

  init(id: UUID = UUID(), quote: String, author: String) {
    self.id = id
    self.quote = quote
    self.author = author
  }

  static let samples = [
    ZenQuote(
      quote: "When we realize that we are the ocean, we are no longer afraid of the waves.",
      author: "Dogen Zenji"),
    ZenQuote(
      quote: "We do not exist for the sake of something else. We exist for the sake of ourselves.",
      author: "Shunryu Suzuki"),
    ZenQuote(
      quote: "If you realize you have enough, you are truly rich.",
      author: "Lao Tzu"),
    ZenQuote(
      quote:
        "If you miss the present moment, you miss your appointment with life. That is very serious!",
      author: "Thich Nhat Hanh"),
    ZenQuote(
      quote: "Let go, or be dragged.",
      author: "Zen Proverb"),
  ]
}
