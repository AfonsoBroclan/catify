//
//  CatModel.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

struct CatModel: Decodable {

    let id: String
    let url: URL?
    let breeds: [Breed]
}
