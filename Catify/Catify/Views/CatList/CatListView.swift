//
//  CatListView.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct CatListView: View {
    @StateObject var viewModel: CatListViewModel

    var body: some View {

        switch self.viewModel.state {

        case .error:
            self.errorView
        case .loading:
            self.emptyView
        case .loaded,
                .loadingMore:
            if self.viewModel.cats.count == 0 && self.viewModel.breedSearch.isEmpty {

                self.emptyView

            } else {
                NavigationStack {
                    List {

                        Section {
                            self.favouriteAverageLifeSpan
                        }

                        if self.viewModel.cats.count == 0 {

                            self.emptySearchView

                        } else {
                            ForEach(self.$viewModel.cats) { $cat in

                                NavigationLink {
                                    CatDetailView(cat: $cat,
                                                  favouriteProtocol: self.viewModel.appViewModel)
                                } label: {
                                    CatListRow(cat: $cat,
                                               favouriteProtocol: self.viewModel.appViewModel)
                                }
                            }

                            Section {
                                self.footerView
                            }
                        }
                    }
                    .searchable(text: self.$viewModel.breedSearch, prompt: "Search for a particular breed")
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
            if self.viewModel.state == .loading {

                ProgressView()
            } else {
                
                Text("Unfortunately there are no cats today! \nThey are currently getting a training in hell! 😈")
                    .multilineTextAlignment(.center)
            }
        case .favourite:
            Text("Go add some favourite cats!")
        }
    }

    @ViewBuilder var emptySearchView: some View {
        VStack {
            Text("We don't have any cats that match that query, try to fetch some more!")
                .multilineTextAlignment(.center)

            Divider()

            Button("Fetch more!") {
                self.viewModel.fetchMoreCats()
            }
            .padding()
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

    @ViewBuilder var footerView: some View {

        if self.viewModel.breedSearch.isEmpty && self.viewModel.type == .all {

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
        } else {

            EmptyView()
        }
    }
}

#Preview {
    CatListView(viewModel: CatListViewModel(appViewModel: AppViewModel(), type: .all))
}
