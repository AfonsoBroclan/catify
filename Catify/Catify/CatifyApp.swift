//
//  CatifyApp.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import SwiftUI

@main
struct CatifyApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
           // ContentView()
           //     .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
