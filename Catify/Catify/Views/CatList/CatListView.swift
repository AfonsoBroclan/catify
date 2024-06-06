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

        switch self.viewModel.state {

        case .error:
            self.errorView
        case .loading:
            self.emptyView
        case .loaded,
                .loadingMore:
            if self.$viewModel.cats.count == 0 {
                Text("Unfortunately there are no cats today! \nThey are currently getting a training in hell! 😈")
                    .multilineTextAlignment(.center)
            } else {
                NavigationStack {
                    List {

                        Section {
                            self.favouriteAverageLifeSpan
                        }

                        ForEach(self.$viewModel.cats, id: \.id) { cat in

                            NavigationLink {
                                CatDetailView(cat: cat,
                                              favouriteProtocol: self.viewModel.appViewModel)
                            } label: {
                                CatListRow(cat: cat,
                                           favouriteProtocol: self.viewModel.appViewModel)
                            }
                        }

                        if self.viewModel.breedSearch.isEmpty {

                            Section {
                                HStack {

                                    Spacer()
                                    ZStack {
                                        Button("Fetch more!") {
                                            self.viewModel.fetchMoreCats()
                                        }
                                        .disabled(self.viewModel.state != .loaded)

                                        if self.viewModel.state == .loadingMore {

                                            ProgressView()
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .searchable(text: self.$viewModel.breedSearch)
                }
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

    @ViewBuilder var errorView: some View {
        
        VStack {

            Text("Something went wront, please retry!")

            Button {
                self.viewModel.retry()
            } label: {
                Text("Retry")
            }
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
