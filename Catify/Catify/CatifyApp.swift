//
//  CatifyApp.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

@main
struct CatifyApp: App {
    @State var appViewModel = AppViewModel(coreDataManager: CoreDataManager())

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: self.appViewModel)
        }
    }
}
