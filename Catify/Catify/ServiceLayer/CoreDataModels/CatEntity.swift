//
//  CatEntity.swift
//  Catify
//
//  Created by Afonso Rosa on 04/06/2024.
//

import CoreData

class CatEntity: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var url: String?
    @NSManaged var isFavourite: Bool
    @NSManaged var breeds: Set<BreedEntity>?
}

extension CatEntity {

    var cat: Cat {

        Cat(id: self.id,
            url: URL(string: self.url ?? ""),
            breeds: self.breeds?.map { $0.breed } ?? [],
            isFavourite: self.isFavourite)
    }

    class func fetchRequest() -> NSFetchRequest<CatEntity> {

        return NSFetchRequest<CatEntity>(entityName: "CatEntity")
    }
}

extension Cat {

    func toCatEntity(context: NSManagedObjectContext) -> CatEntity {

        let entity = CatEntity(context: context)
        entity.id = self.id
        entity.url = self.url?.absoluteString
        entity.isFavourite = self.isFavourite
        entity.breeds = Set(self.breeds.map { $0.toBreedEntity(context: context) })
        return entity
    }
}
