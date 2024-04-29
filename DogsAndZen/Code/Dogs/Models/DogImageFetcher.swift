//
//  DogImageFetcher.swift
//  DogsAndZen
//
//  Created by John Price on 4/10/24.
//

import Foundation

/// Handles fetching of dog images from the API.
class DogImageFetcher: ObservableObject {
  @Published var dogs: [DogImage] = DogImage.samples
}
