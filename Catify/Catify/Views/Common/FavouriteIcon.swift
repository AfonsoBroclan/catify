//
//  FavouriteIcon.swift
//  Catify
//
//  Created by Afonso Rosa on 02/06/2024.
//

import SwiftUI

struct FavouriteIcon: View {
    @Binding var cat: Cat
    var favouriteProtocol: FavouriteProtocol

    var body: some View {
        Image(systemName: self.cat.isFavourite ? "star.fill" : "star")
            .onTapGesture {

                self.favouriteProtocol.toggleFavourite(for: self.cat)
            }
    }
}

#Preview {
    FavouriteIcon(cat: .constant(Cat.mockedCat), favouriteProtocol: AppViewModel())
}
