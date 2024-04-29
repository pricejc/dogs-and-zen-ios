//
//  Utilities.swift
//  DogsAndZen
//
//  Created by John Price on 4/19/24.
//

import Foundation

/// Creates a `Date` from the specified components.
///
/// - Parameters:
///     - year: The year
///     - month: The month
///     - day: The day
///     - hours: The hours
///     - minutes: The minutes
///     - seconds: The seconds
///
/// - Returns: A date with the specified parameters.
func createDate(year: Int, month: Int, day: Int, hours: Int = 0, minutes: Int = 0, seconds: Int = 0)
  -> Date
{
  var dateComponents = DateComponents()
  dateComponents.year = year
  dateComponents.month = month
  dateComponents.day = day
  dateComponents.hour = hours
  dateComponents.minute = minutes
  dateComponents.second = seconds

  return Calendar.current.date(from: dateComponents)!
}

/// Returns a number of remaining seconds in the hh:mm format.
///
/// - Parameters:
///     - The remaining seconds.
///
/// - Returns: A string in the hh:mm format.
func prettifyCountdown(remaining: Int) -> String {
  return String(format: "%.2d:%.2d", remaining / 60, remaining % 60)
}

/// Returns a random `DogImage`/`ZenQuote` combo.
///
/// - Returns: A random `DogImage` and `ZenQuote`
func getRandomDogQuote() -> (DogImage, ZenQuote) {
  return (DogImage.samples.randomElement()!, ZenQuote.samples.randomElement()!)
}

/// Returns a collection of `DogImage`/`ZenQuote` combinations.
func getDogQuotes() -> [(DogImage, ZenQuote)] {
  return Array(zip(DogImage.samples, ZenQuote.samples))
}
