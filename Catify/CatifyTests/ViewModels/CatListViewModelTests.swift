//
//  CatListViewModelTests.swift
//  CatifyTests
//
//  Created by Afonso Rosa on 04/06/2024.
//

import XCTest
@testable import Catify

final class CatListViewModelTests: XCTestCase {

    var appViewModel: AppViewModel?
    var catListViewModel: CatListViewModel?

    override func setUpWithError() throws {

        try super.setUpWithError()

        self.appViewModel = AppViewModel(api: APIMock())

        let fetchExpectation = XCTestExpectation(description: "waiting for cats")

        self.appViewModel?.viewDidLoad()

        withObservationTracking {

            _ = self.appViewModel?.cats
        } onChange: {

            fetchExpectation.fulfill()
        }

        wait(for: [fetchExpectation], timeout: 1)

        let appViewModel = try XCTUnwrap(self.appViewModel)

        self.catListViewModel = CatListViewModel(appViewModel: appViewModel, type: .all)
    }

    override func tearDown() {
        super.tearDown()

        self.catListViewModel = nil
        self.appViewModel = nil
    }

    func testFavouriteLogic() throws {

        let appViewModel = try XCTUnwrap(self.appViewModel)

        let catListViewModel = try XCTUnwrap(self.catListViewModel)

        XCTAssertEqual(catListViewModel.cats.count, 3)

        catListViewModel.toggleFavourite(for: catListViewModel.cats[0])

        XCTAssertEqual(appViewModel.favouriteCats.count, 1)

        catListViewModel.toggleFavourite(for: catListViewModel.cats[0])

        XCTAssertEqual(appViewModel.favouriteCats.count, 0)
    }

    func testSearch() throws {

        let appViewModel = try XCTUnwrap(self.appViewModel)

        let catListViewModel = try XCTUnwrap(self.catListViewModel)

        catListViewModel.breedSearch = "Aby"

        XCTAssertEqual(catListViewModel.cats.count, 2)
        XCTAssertEqual(appViewModel.cats.count, 3)
    }

    func testAverageMinimumSpan() throws {

        let appViewModel = try XCTUnwrap(self.appViewModel)

        let catListViewModel = try XCTUnwrap(self.catListViewModel)

        XCTAssertEqual(catListViewModel.averageMinimumLifeSpan, "11")
    }
}

// MARK: Helpers
private extension CatListViewModelTests {

}
