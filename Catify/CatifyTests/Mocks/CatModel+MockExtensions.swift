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

    static var mockedCat2: CatModel {

        CatModel(id: "ozEvzdVM-",
                 url: URL(string: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg"),
                 breeds: [Breed.mockedBreed2])
    }
}

extension Breed {

    static var mockedBreed2: Breed {

        Breed(id: "aege",
              name: "Aegean",
              temperament: "Affectionate, Social, Intelligent, Playful, Active",
              origin: "Greece",
              breedDescription: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
              lifeSpan: "9 - 12",
              referenceImageId: "ozEvzdVM-")
    }
}
