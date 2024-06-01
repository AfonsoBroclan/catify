//
//  CatListViewModel.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

class CatListViewModel: ObservableObject {

    private let api: CatAPI
    private var currentPage = 0
    private var canFetchMore = true

    private var fetchedCats = [Cat]() {

        didSet {
            self.cats = self.fetchedCats
        }
    }
    @Published var cats = [Cat]()
    @Published var breedSearch = "" {

        didSet {
            if self.breedSearch.isEmpty {

                self.cats = self.fetchedCats

            } else {

                self.cats = self.cats.filter { $0.breedName.lowercased().contains(self.breedSearch.lowercased()) }
            }
        }
    }

    init(api: CatAPI = CatServices()) {
        self.api = api
    }

    func viewDidLoad() {

        self.fetchCats()
    }

    private enum Constants {

        static let numberOfCatsPerPage = 20
    }
}

// Mark: Fetch
private extension CatListViewModel {

    func fetchCats() {

        if self.canFetchMore == false {

            return
        }

        Task {

            let (catModels, error) = await self.api.fetchCats(page: self.currentPage, number: Constants.numberOfCatsPerPage)

            if let catModels {

                if cats.isEmpty {

                    self.canFetchMore = false
                }

                let cats = catModels.map { Cat($0) }

                await MainActor.run {

                    self.fetchedCats.append(contentsOf: cats)
                }

                self.currentPage += 1

            } else {

                print("Something went wrong: \(error.debugDescription)")
            }
        }
    }
}
