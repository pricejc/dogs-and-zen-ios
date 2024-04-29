//
//  ZenQuoteFetcher.swift
//  DogsAndZen
//
//  Created by John Price on 4/23/24.
//

import Foundation

/// Handles fetching of quotes from the API.
class ZenQuoteFetcher: ObservableObject {
  @Published var quotes: [ZenQuote] = ZenQuote.samples
}
