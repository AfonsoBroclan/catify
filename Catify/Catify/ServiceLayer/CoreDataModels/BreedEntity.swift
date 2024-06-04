//
//  BreedEntity.swift
//  Catify
//
//  Created by Afonso Rosa on 04/06/2024.
//

import CoreData

class BreedEntity: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var temperament: String
    @NSManaged var origin: String
    @NSManaged var breedDescription: String
    @NSManaged var lifeSpan: String
    @NSManaged var referenceImageId: String
}

extension BreedEntity {

    var breed: Breed {

        Breed(id: self.id,
              name: self.name,
              temperament: self.temperament,
              origin: self.origin,
              breedDescription: self.breedDescription,
              lifeSpan: self.lifeSpan,
              referenceImageId: self.referenceImageId)
    }
}

extension Breed {
    func toBreedEntity(context: NSManagedObjectContext) -> BreedEntity {
        let entity = BreedEntity(context: context)
        entity.id = self.id
        entity.name = self.name
        entity.temperament = self.temperament
        entity.origin = self.origin
        entity.breedDescription = self.breedDescription
        entity.lifeSpan = self.lifeSpan
        entity.referenceImageId = self.referenceImageId
        return entity
    }
}
