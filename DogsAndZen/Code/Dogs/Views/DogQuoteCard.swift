//
//  DogQuoteCard.swift
//  DogsAndZen
//
//  Created by John Price on 4/10/24.
//

import SwiftUI

/// A Card containing a DogImage and ZenQuote.
struct DogQuoteCard: View {
  var dog: DogImage
  var quote: ZenQuote

  @State private var showQuote = true

  var body: some View {
    Card {
      HStack {
        Image(dog.imagePath)
          .resizable()
          .scaledToFill()
          .frame(maxWidth: .infinity, maxHeight: 300)
          .clipped()
          .clipShape(.rect(cornerRadius: 10))
          .overlay {
            ZStack {
              RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1).fill(.black).opacity(
                0.6)
              VStack {
                Text(quote.quote)
                  .foregroundStyle(.white)
                  .padding()
                  .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                  .fontWeight(.ultraLight)
                Text("- \(quote.author)")
                  .foregroundStyle(.white)
                  .padding()
                  .fontWeight(.light)
              }

            }.opacity(showQuote ? 1 : 0)
          }
      }
      .clipShape(.rect(cornerRadius: 10))
    }
    .onTapGesture {
      showQuote.toggle()
    }
  }
}

#Preview {
  let dog: DogImage = DogImage.samples.randomElement()!
  let quote: ZenQuote = ZenQuote.samples.randomElement()!
  return DogQuoteCard(dog: dog, quote: quote)
}
