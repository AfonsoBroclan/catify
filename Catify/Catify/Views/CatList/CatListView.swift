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
            ProgressView()
                .onAppear {
                    self.viewModel.viewDidLoad()
                }
        } else {
            NavigationStack {
                List {
                    ForEach(self.$viewModel.cats, id: \.id) { cat in

                        CatListRow(cat: cat)
                    }
                }
                .searchable(text: self.$viewModel.breedSearch)
            }
        }
    }
}

#Preview {
    CatListView(viewModel: CatListViewModel())
}
