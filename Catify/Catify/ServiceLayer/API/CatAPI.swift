//
//  CatAPI.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

enum CustomErrors: Error {

    case invalidURL
    case invalidJSON
}

typealias CatListResult = ([CatModel]?, CustomErrors?)

protocol CatAPI {
    
    func fetchCats(page: Int, number: Int) async -> CatListResult 
}
