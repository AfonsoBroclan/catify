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
            if self.breedSearch.isEmpty {

                self.cats = self.appViewModel.cats

            } else {

                self.cats = self.cats.filter { $0.breedName.lowercased().contains(self.breedSearch.lowercased()) }
            }
        }
    }

    init(appViewModel: AppViewModel, type: ListType) {
        self.appViewModel = appViewModel
        self.type = type
        self.cats = type == .all ? appViewModel.cats : appViewModel.favouriteCats
    }

    func toggleFavourite(for cat: Cat) {

        self.appViewModel.toggleFavourite(for: cat)
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
