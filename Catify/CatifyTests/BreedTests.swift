//
//  BreedTests.swift
//  CatifyTests
//
//  Created by Afonso Rosa on 03/06/2024.
//

import Foundation
import XCTest

@testable import Catify

class BreedTests: XCTestCase {
    
    func testMinimumLifeSpan() {

        let breed = Breed.mockedBreed

        XCTAssertEqual(breed.minimumLifeSpan, 14)

        let noLifeSpanBreed = Breed()

        XCTAssertNil(noLifeSpanBreed.minimumLifeSpan)

        let weirdLifeSpanBreed = Breed(lifeSpan: "-")

        XCTAssertNil(weirdLifeSpanBreed.minimumLifeSpan)
    }

    func testAverageMinimumLifeSpan() {

        let breed = Breed.mockedBreed

        var breeds = [breed]

        XCTAssertEqual(breeds.averageMinimumLifeSpan, 14)

        let noLifeSpanBreed = Breed()
        breeds.append(noLifeSpanBreed)

        XCTAssertEqual(breeds.averageMinimumLifeSpan, 14)

        let diffLifeSpanBreed = Breed(lifeSpan: "12 - 16")
        breeds.append(diffLifeSpanBreed)

        XCTAssertEqual(breeds.averageMinimumLifeSpan, 13)

        breeds.removeFirst()

        XCTAssertEqual(breeds.averageMinimumLifeSpan, 12)

        breeds.removeLast()

        XCTAssertNil(breeds.averageMinimumLifeSpan)
    }
}
