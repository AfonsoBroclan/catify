//
//  CoreDataManager.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import CoreData

class CoreDataManager {

    private lazy var container: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Catify")
        container.loadPersistentStores { store, error in

            if let error = error {
                assertionFailure("Unresolved error \(error)")
            }
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        return self.container.viewContext
    }

    func saveCat(cat: Cat) {

        _ = cat.toCatEntity(context: self.context)

        do {

            try self.context.save()
        } catch {
            assertionFailure("Failed to save cat: \(error)")
        }
    }

    var savedCats: [Cat] {

        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()

        do {
            
            let results = try self.context.fetch(fetchRequest)
            return results.map { $0.cat }

        } catch {

            assertionFailure("Failed to fetch cats: \(error)")
            return []
        }
    }
    
    func toggleFavourite(cat: Cat) {
        
        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cat.id)

        do {
            if let entity = try self.context.fetch(fetchRequest).first {
                entity.isFavourite = cat.isFavourite
                try self.context.save()
            }
        } catch {
            assertionFailure("Failed to favourite cat: \(error)")
        }
    }
}
