//
//  CatListRow.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct CatListRow: View {
    @Binding var cat: Cat
    var favouriteProtocol: FavouriteProtocol

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

            FavouriteIcon(cat: self.$cat, favouriteProtocol: self.favouriteProtocol)
        }
        .padding()
    }
}

#Preview {
    CatListRow(cat: .constant(Cat.mockedCat), favouriteProtocol: AppViewModel())
}
