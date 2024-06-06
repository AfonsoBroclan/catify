//
//  AppViewModel.swift
//  Catify
//
//  Created by Afonso Rosa on 02/06/2024.
//

import CoreData
import Foundation
import SwiftUI

enum AppState {

    case error
    case loaded
    case loading
    case loadingMore
}

@Observable final class AppViewModel {

    private let api: CatAPI
    private let coreDataManager: CoreDataManager?
    private var currentPage = 0
    private var canFetchMore = true

    var cats = [Cat]() {

        didSet {

            self.favouriteCats = self.cats.filter { $0.isFavourite }
        }
    }
    var favouriteCats = [Cat]()
    var state: AppState = .loading

    init(api: CatAPI = CatServices(), coreDataManager: CoreDataManager? = nil) {
        self.api = api
        self.coreDataManager = coreDataManager
    }

    func viewDidLoad() {

        self.fetchCats()
    }

    func fetchMoreCats() {

        self.fetchCats(shouldFetchMore: true)
    }

    func retry() {

        guard self.state == .error else { return }

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

            var newCat = self.cats[index]
            newCat.isFavourite.toggle()

            self.cats[index] = newCat
            self.coreDataManager?.toggleFavourite(cat: newCat)

        } else {
            
            assertionFailure("Cat with id \(cat.id) doesn't exist, this should not be possible.")
        }
    }
}

// MARK: Fetch
private extension AppViewModel {

    func fetchCats(shouldFetchMore: Bool = false) {

        if self.canFetchMore == false {

            return
        }

        self.state = shouldFetchMore ? .loadingMore : .loading

        if shouldFetchMore == false {

            let savedCats = self.coreDataManager?.savedCats ?? []

            if savedCats.isEmpty == false {

                self.cats = savedCats
                self.state = .loaded
                return
            }
        }

        Task { [weak self] in

            guard let self else { return }

            let (catModels, error) = await self.api.fetchCats(page: self.currentPage, number: Constants.numberOfCatsPerPage)

            if let catModels {

                if catModels.isEmpty {

                    self.canFetchMore = false
                }

                let newCats = catModels.map { Cat($0) }

                await MainActor.run {

                    var currentCats = self.cats

                    currentCats.append(contentsOf: newCats)

                    self.cats = currentCats.noDuplicates

                    for cat in newCats {

                        self.coreDataManager?.saveCat(cat: cat)
                    }
                    self.state = .loaded
                }

                self.currentPage += 1

            } else {

                switch error {

                case .invalidURL:
                    assertionFailure("URL is wrong, this should not be possible!")

                case .invalidJSON:
                    assertionFailure("Something went wrong with the parser.")

                case .none:
                    break
                }

                print("Something went wrong: \(error.debugDescription)")
                await MainActor.run {
                    self.state = .error
                }
            }
        }
    }
}
