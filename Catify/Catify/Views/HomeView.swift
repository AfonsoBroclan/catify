//
//  HomeView.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel = AppViewModel()
    @State private var selection: Tab = .list

    enum Tab {
        case list
        case favourite
    }

    var body: some View {
        TabView(selection: $selection) {
            CatListView(viewModel: CatListViewModel(appViewModel: self.viewModel, type: .all))
                .tabItem {
                    Label("Cat List", systemImage: "list.bullet")
                }
                .tag(Tab.list)

            CatListView(viewModel: CatListViewModel(appViewModel: self.viewModel, type: .favourite))
                .tabItem {
                    Label("Favourite Cats", systemImage: "star")
                }
                .tag(Tab.favourite)
        }
        .onAppear {
            self.viewModel.viewDidLoad()
        }
    }
}

#Preview {
    HomeView()
}
