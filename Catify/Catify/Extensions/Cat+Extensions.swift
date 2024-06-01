//
//  Cat+Extensions.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

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
