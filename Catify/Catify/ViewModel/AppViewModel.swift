//
//  AppViewModel.swift
//  Catify
//
//  Created by Afonso Rosa on 02/06/2024.
//

import Foundation
import SwiftUI

@Observable final class AppViewModel {

    private let api: CatAPI
    private var currentPage = 0
    private var canFetchMore = true

    var cats = [Cat]() {

        didSet {

            self.favouriteCats = self.cats.filter { $0.isFavourite }
        }
    }
    var favouriteCats = [Cat]()

    init(api: CatAPI = CatServices()) {
        self.api = api
    }

    func viewDidLoad() {

        self.fetchCats()
    }

    func toggleFavourite(for cat: Cat) {

        if let index = self.cats.firstIndex(where: { $0.id == cat.id }) {

            self.cats[index].isFavourite.toggle()
        }
    }

    private enum Constants {

        static let numberOfCatsPerPage = 20
    }
}

// Mark: Fetch
private extension AppViewModel {

    func fetchCats() {

        if self.canFetchMore == false {

            return
        }

        Task {

            let (catModels, error) = await self.api.fetchCats(page: self.currentPage, number: Constants.numberOfCatsPerPage)

            if let catModels {

                if catModels.isEmpty {

                    self.canFetchMore = false
                }

                let cats = catModels.map { Cat($0) }

                await MainActor.run {

                    self.cats.append(contentsOf: cats)
                }

                self.currentPage += 1

            } else {

                print("Something went wrong: \(error.debugDescription)")
            }
        }
    }
}
