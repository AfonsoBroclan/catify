//
//  AppViewModelTests.swift
//  CatifyTests
//
//  Created by Afonso Rosa on 01/06/2024.
//

import XCTest
@testable import Catify

final class AppViewModelTests: XCTestCase {

    func testFetch() {

        let appViewModel = AppViewModel(api: APIMock(withSuccess: true))

        let expectation = XCTestExpectation(description: "waiting for cats")

        appViewModel.viewDidLoad()

        withObservationTracking {

            _ = appViewModel.cats
        } onChange: {

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(appViewModel.cats.count, 3)
        XCTAssertEqual(appViewModel.favouriteCats.count, 0)
    }
}
