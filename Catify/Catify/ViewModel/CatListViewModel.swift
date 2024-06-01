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

    @Published var cats = [Cat]()
    @Published var breedSearch = ""
    var searchResults: [Cat] {

        if self.breedSearch.isEmpty {

            return self.cats

        } else {

            return self.cats.filter { $0.breedName.lowercased().contains(self.breedSearch.lowercased()) }
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

            let (cats, error) = await self.api.fetchCats(page: self.currentPage, number: Constants.numberOfCatsPerPage)

            if let cats {

                if cats.isEmpty {

                    self.canFetchMore = false
                }

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
