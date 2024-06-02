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

    init(id: String, url: URL?, breeds: [Breed], isFavourite: Bool) {

        self.id = id
        self.url = url
        self.breeds = breeds
        self.isFavourite = isFavourite
    }

    init(_ cat: CatModel) {

        self = Cat(id: cat.id, url: cat.url, breeds: cat.breeds, isFavourite: false)
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
