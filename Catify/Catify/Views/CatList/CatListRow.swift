//
//  CatListRow.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct CatListRow: View {
    @Binding var cat: Cat
    @ObservedObject var viewModel: CatListViewModel

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

            Image(systemName: self.cat.isFavourite ? "star.fill" : "star")
                .onTapGesture {

                    self.viewModel.toggleFavourite(for: self.cat)
                }
        }
        .padding()
    }
}

#Preview {
    CatListRow(cat: .constant(Cat(id: "0XYvRd7oD",
                                  url: URL(string: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"),
                                  breeds: [Breed(name: "Abyssinian",
                                                 lifeSpan: "14 - 15")], 
                                  isFavourite: true)),
               viewModel: CatListViewModel(appViewModel: AppViewModel(), type: .all))
}
