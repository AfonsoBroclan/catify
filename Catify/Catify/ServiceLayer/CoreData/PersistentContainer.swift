//
//  PersistentContainer.swift
//  Catify
//
//  Created by Afonso Rosa on 05/06/2024.
//

import CoreData

class PersistentContainer: NSPersistentContainer {

    override func loadPersistentStores(completionHandler: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        super.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error)")

                self.handlePersistentStoreError(error)
            } else {
                completionHandler(storeDescription, nil)
            }
        }
    }

    private func handlePersistentStoreError(_ error: NSError) {

        if let storeURL = self.persistentStoreDescriptions.first?.url {
            do {
                
                try FileManager.default.removeItem(at: storeURL)
                try self.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)

            } catch {

                assertionFailure("Failed to create a new persistent store: \(error.localizedDescription)")
            }
        }
    }
}

