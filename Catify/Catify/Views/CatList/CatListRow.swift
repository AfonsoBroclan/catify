//
//  CatListRow.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct CatListRow: View {
    var cat: Cat

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
        }
        .padding()
    }
}

#Preview {
    CatListRow(cat: Cat(id: "0XYvRd7oD",
                        url: URL(string: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"),
                        breeds: [Breed(name: "Abyssinian")]))
}
