//
//  CatDetailView.swift
//  Catify
//
//  Created by Afonso Rosa on 02/06/2024.
//

import SwiftUI

struct CatDetailView: View {
    @Binding var cat: Cat
    var favouriteProtocol: FavouriteProtocol

    var body: some View {

        ForEach(cat.breeds, id: \.id) { breed in

            VStack {

                FavouriteIcon(cat: self.$cat, favouriteProtocol: self.favouriteProtocol)

                VStack(alignment: .leading) {
                    HStack {

                        Text(breed.name)
                        Spacer()
                        Text(breed.origin)
                    }

                    Divider()
                    Text(breed.temperament)

                    Divider()
                    Text(breed.breedDescription)
                }
            }
            .padding()

            Spacer()
        }
    }
}

#Preview {
    CatDetailView(cat: .constant(Cat.mockedCat),
                  favouriteProtocol: AppViewModel())
}
