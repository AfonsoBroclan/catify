//
//  AppViewModel.swift
//  Catify
//
//  Created by Afonso Rosa on 02/06/2024.
//

import CoreData
import Foundation
import SwiftUI

@Observable final class AppViewModel {

    private let api: CatAPI
    private let coreDataManager: CoreDataManager
    private var currentPage = 0
    private var canFetchMore = true

    var cats = [Cat]() {

        didSet {

            self.favouriteCats = self.cats.filter { $0.isFavourite }
        }
    }
    var favouriteCats = [Cat]()

    init(api: CatAPI = CatServices(), coreDataManager: CoreDataManager = CoreDataManager()) {
        self.api = api
        self.coreDataManager = coreDataManager
    }

    func viewDidLoad() {

        self.fetchCats()
    }

    private enum Constants {

        static let numberOfCatsPerPage = 20
    }
}

// MARK: FavouriteProtocol
extension AppViewModel: FavouriteProtocol {

    func toggleFavourite(for cat: Cat) {

        if let index = self.cats.firstIndex(where: { $0.id == cat.id }) {

            var newCat = cat
            newCat.isFavourite.toggle()

            self.cats[index] = newCat
            self.coreDataManager.toggleFavourite(cat: newCat)
        }
    }
}

// MARK: Fetch
private extension AppViewModel {

    func fetchCats() {

        if self.canFetchMore == false {

            return
        }

        let savedCats = self.coreDataManager.savedCats

        if savedCats.isEmpty == false {

            self.cats = savedCats
            return
        }

        Task { [weak self] in

            guard let self else { return }

            let (catModels, error) = await self.api.fetchCats(page: self.currentPage, number: Constants.numberOfCatsPerPage)

            if let catModels {

                if catModels.isEmpty {

                    self.canFetchMore = false
                }

                let cats = catModels.map { Cat($0) }

                await MainActor.run {

                    self.cats.append(contentsOf: cats)

                    for cat in self.cats {

                        self.coreDataManager.saveCat(cat: cat)
                    }
                }

                self.currentPage += 1

            } else {

                print("Something went wrong: \(error.debugDescription)")
            }
        }
    }
}
