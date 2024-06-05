//
//  CoreDataManager.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import CoreData

class CoreDataManager {

    var hasError = false

    private lazy var container: PersistentContainer = {

        let container = PersistentContainer(name: "Catify")
        container.loadPersistentStores { [weak self] _, error in

            self?.hasError = error != nil
        }
        return container
    }()

    private var context: NSManagedObjectContext {

        if self.hasError {

            self.container.loadPersistentStores { [weak self] _, error in

                self?.hasError = error != nil
            }
        }

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
