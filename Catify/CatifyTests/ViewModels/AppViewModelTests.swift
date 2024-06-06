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

        let appViewModel = AppViewModel(api: APIMock())

        let expectation = XCTestExpectation(description: "waiting for cats")

        appViewModel.viewDidLoad()

        withObservationTracking {

            _ = appViewModel.cats
        } onChange: {

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(appViewModel.cats.count, 2)
        XCTAssertEqual(appViewModel.favouriteCats.count, 0)
    }

    func testFavouriteLogic() {

        let appViewModel = AppViewModel(api: APIMock())

        let fetchExpectation = XCTestExpectation(description: "waiting for cats")

        appViewModel.viewDidLoad()

        withObservationTracking {

            _ = appViewModel.cats
        } onChange: {

            fetchExpectation.fulfill()
        }
        wait(for: [fetchExpectation], timeout: 1)

        XCTAssertEqual(appViewModel.cats.count, 2)
        XCTAssertEqual(appViewModel.favouriteCats.count, 0)

        appViewModel.toggleFavourite(for: appViewModel.cats[0])

        XCTAssertEqual(appViewModel.cats.count, 2)
        XCTAssertEqual(appViewModel.favouriteCats.count, 1)

        appViewModel.toggleFavourite(for: appViewModel.cats[0])

        XCTAssertEqual(appViewModel.cats.count, 2)
        XCTAssertEqual(appViewModel.favouriteCats.count, 0)
    }
}
