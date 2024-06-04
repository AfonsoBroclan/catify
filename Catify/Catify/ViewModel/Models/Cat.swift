//
//  File.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

struct Cat {

    let id: String
    let url: URL?
    let breeds: [Breed]
    var isFavourite: Bool

    init(_ cat: CatModel) {

        self = Cat(id: cat.id, url: cat.url, breeds: cat.breeds, isFavourite: false)
    }
}

// MARK: Protocol conformances
extension Cat: Equatable {

    static func == (lhs: Cat, rhs: Cat) -> Bool {

        return lhs.id == rhs.id
    }
}

// MARK: - Helper methods
extension Cat {

    var breedName: String {

        if self.breeds.isEmpty {

            return "This cat is a stray!"
        }

        let breedNames = self.breeds.reduce("") { partialResult, breed in

            if partialResult.isEmpty {
                return breed.name
            } else {
                return ", \(breed.name)"
            }
        }

        let breedsArticle = self.breeds.count > 1 ? "a mix of the breeds" : "of breed"

        return "This cat is \(breedsArticle): \(breedNames)"
    }
}

// MARK: Mock purposes
extension Cat {

    init(id: String = "", url: URL? = nil, breeds: [Breed] = [], isFavourite: Bool = false) {

        self.id = id
        self.url = url
        self.breeds = breeds
        self.isFavourite = isFavourite
    }

    static var mockedCat: Cat {
        Cat(id: "0XYvRd7oD",
            url: URL(string: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"),
            breeds: [Breed.mockedBreed],
            isFavourite: true)
    }
}
