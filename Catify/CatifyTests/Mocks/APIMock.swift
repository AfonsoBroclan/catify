//
//  APIMock.swift
//  CatifyTests
//
//  Created by Afonso Rosa on 02/06/2024.
//

import Foundation

@testable import Catify

final class APIMock: CatAPI {
    
    let withSuccess: Bool

    init(withSuccess: Bool = true) {
        self.withSuccess = withSuccess
    }

    func fetchCats(page: Int, number: Int) async -> CatListResult {

        if self.withSuccess {

            let cats = [CatModel.mockedCat, CatModel.mockedCat2, CatModel.mockedCat]

            return (cats, nil)

        } else {

            return (nil, .invalidJSON)
        }
    }
}
