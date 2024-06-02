//
//  Breed.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

struct Breed: Decodable, Hashable {

    let name: String
    let lifeSpan: String

    enum CodingKeys: String, CodingKey {
        case name
        case lifeSpan = "life_span"
    }

    init(name: String, lifeSpan: String) {

        self.name = name
        self.lifeSpan = lifeSpan
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
    }
}
