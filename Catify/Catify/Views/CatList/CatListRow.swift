//
//  CatListRow.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct CatListRow: View {
    @Binding var cat: Cat

    private var favouriteIcon: String {
        self.$cat.wrappedValue.isFavourite ? "star.fill" : "star"
    }

    var body: some View {
        HStack {

            AsyncImage(url: self.cat.url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            Text(self.cat.breedName)

            Spacer()

            Image(systemName: self.favouriteIcon)
                .onTapGesture {

                    if self.cat.isFavourite {
                        self.cat.removeAsFavourite()
                    } else {
                        self.cat.addAsFavourite()
                    }
                }
        }
        .padding()
    }
}

#Preview {
    CatListRow(cat: .constant(Cat(id: "0XYvRd7oD",
                                  url: URL(string: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"),
                                  breeds: [Breed(name: "Abyssinian")], 
                                  isFavourite: true)))
}
