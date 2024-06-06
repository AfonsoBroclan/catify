//
//  CatListViewModel.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation
import SwiftUI

enum ListType {

    case all
    case favourite
}

class CatListViewModel: ObservableObject {

    private(set) var appViewModel: AppViewModel

    let type: ListType

    @Published var cats = [Cat]()
    @Published var breedSearch = "" {

        didSet {

            self.filterCats()
        }
    }
    @Published var state: AppState

    init(appViewModel: AppViewModel, type: ListType) {
        self.appViewModel = appViewModel
        self.type = type
        self.cats = type == .all ? appViewModel.cats : appViewModel.favouriteCats
        self.state = appViewModel.state
    }

    func fetchMoreCats() {

        self.breedSearch = ""
        self.appViewModel.fetchMoreCats()
    }

    func toggleFavourite(for cat: Cat) {

        self.appViewModel.toggleFavourite(for: cat)
    }

    func retry() {

        self.appViewModel.retry()
    }
}

private extension CatListViewModel {

    func filterCats() {

        if self.breedSearch.isEmpty {

            self.cats = self.appViewModel.cats

        } else {

            self.cats = self.appViewModel.cats.filter { cat in

                cat.breeds.contains { breed in

                    breed.name.lowercased().contains(self.breedSearch.lowercased())
                }
            }
        }
    }
}

// MARK: LifeSpan
extension CatListViewModel {

    var averageMinimumLifeSpan: String? {

        let breeds = self.cats.compactMap { $0.breeds }.flatMap { $0 }

        guard let average = breeds.averageMinimumLifeSpan else { return nil }

        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2

        return numberFormatter.string(from: NSNumber(floatLiteral: average))
    }
}
