//
//  CatListView.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct CatListView: View {
    @ObservedObject var viewModel: CatListViewModel

    var body: some View {

        if self.$viewModel.cats.isEmpty {
            self.emptyView
        } else {
            NavigationStack {
                List {

                    Section {
                        self.favouriteAverageLifeSpan
                    }

                    ForEach(self.$viewModel.cats, id: \.id) { cat in

                        CatListRow(cat: cat, viewModel: self.viewModel)
                    }
                }
                .searchable(text: self.$viewModel.breedSearch)
            }
        }
    }
}

// MARK: Subviews
extension CatListView {

    @ViewBuilder var emptyView: some View {
        switch self.viewModel.type {
        case .all:
            ProgressView()
        case .favourite:
            Text("Go add some favourite cats!")
        }
    }

    @ViewBuilder var favouriteAverageLifeSpan: some View {

        if self.viewModel.type == .favourite,
           let average = self.viewModel.averageMinimumLifeSpan {

            Text("The average lifespan of your favourite breeds is \(average)")

        } else {

            EmptyView()
        }
    }
}

#Preview {
    CatListView(viewModel: CatListViewModel(appViewModel: AppViewModel(), type: .all))
}
