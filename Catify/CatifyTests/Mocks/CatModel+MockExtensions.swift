//
//  CatModel+MockExtensions.swift
//  CatifyTests
//
//  Created by Afonso Rosa on 02/06/2024.
//

import Foundation

@testable import Catify

extension CatModel {

    static var mockedCat: CatModel {

        CatModel(id: "0XYvRd7oD",
                 url: URL(string: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"),
                 breeds: [Breed.mockedBreed])
    }
}
