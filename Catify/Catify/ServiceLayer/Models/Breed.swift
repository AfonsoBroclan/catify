//
//  Breed.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

struct Breed: Decodable, Hashable {

    let id: String
    let name: String
    let temperament: String
    let origin: String
    let breedDescription: String
    let lifeSpan: String
    let referenceImageId: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case origin
        case breedDescription = "description"
        case lifeSpan = "life_span"
        case referenceImageId = "reference_image_id"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.temperament = try container.decode(String.self, forKey: .temperament)
        self.origin = try container.decode(String.self, forKey: .origin)
        self.breedDescription = try container.decode(String.self, forKey: .breedDescription)
        self.lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        self.referenceImageId = try container.decode(String.self, forKey: .referenceImageId)
    }
}

// MARK: Mock purposes
extension Breed {

    init(id: String = "",
         name: String = "",
         temperament: String = "",
         origin: String = "",
         breedDescription: String = "",
         lifeSpan: String = "",
         referenceImageId: String = "") {

        self.id = id
        self.name = name
        self.temperament = temperament
        self.origin = origin
        self.breedDescription = breedDescription
        self.lifeSpan = lifeSpan
        self.referenceImageId = referenceImageId
    }

    static var mockedBreed: Breed {

        Breed(id: "abys",
              name: "Abyssinian",
              temperament: "Active, Energetic, Independent, Intelligent, Gentle",
              origin: "Egypt",
              breedDescription: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
              lifeSpan: "14 - 15",
              referenceImageId: "0XYvRd7oD")
    }
}
