//
//  CoreDataManagerTests.swift
//  CatifyTests
//
//  Created by Afonso Rosa on 05/06/2024.
//

import XCTest
import CoreData
@testable import Catify

final class CoreDataManagerTests: XCTestCase {

    var persistentContainer: PersistentContainer!

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.persistentContainer = PersistentContainer(name: "Catify")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        self.persistentContainer.persistentStoreDescriptions = [description]

        self.persistentContainer.loadPersistentStores { (description, error) in
            XCTAssertNil(error, "Failed to load persistent stores: \(error!.localizedDescription)")
        }
    }

    override func tearDown() {
        self.persistentContainer = nil

        super.tearDown()
    }

    func testCreateCat() throws {
        let context = self.persistentContainer.viewContext
        let newCat = CatEntity(context: context)
        newCat.id = Constants.catID
        newCat.url = Constants.catURL
        newCat.isFavourite = false

        try context.save()

        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        let cats = try context.fetch(fetchRequest)

        XCTAssertEqual(cats.count, 1)
        XCTAssertEqual(cats.first?.id, Constants.catID)
        XCTAssertEqual(cats.first?.url, Constants.catURL)
        XCTAssertEqual(cats.first?.isFavourite, false)
    }

    func testUpdateCat() throws {
        let context = self.persistentContainer.viewContext
        let newCat = CatEntity(context: context)
        newCat.id = Constants.catID
        newCat.isFavourite = false

        try context.save()

        newCat.isFavourite = true
        try context.save()

        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        let cats = try context.fetch(fetchRequest)

        XCTAssertEqual(cats.count, 1)
        XCTAssertEqual(cats.first?.isFavourite, true)
    }

    func testDeleteCat() throws {
        let context = self.persistentContainer.viewContext
        let newCat = CatEntity(context: context)
        newCat.id = Constants.catID
        newCat.isFavourite = false

        try context.save()

        context.delete(newCat)
        try context.save()

        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        let cats = try context.fetch(fetchRequest)

        XCTAssertEqual(cats.count, 0)
    }

    func testCatBreeds() throws {
        let context = self.persistentContainer.viewContext
        let newCat = CatEntity(context: context)
        newCat.id = Constants.catID
        newCat.isFavourite = false

        let newBreed = BreedEntity(context: context)
        newBreed.id = Constants.breedID
        newBreed.name = Constants.breedName
        newCat.breeds?.insert(newBreed)

        try context.save()

        let fetchRequest: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        let cats = try context.fetch(fetchRequest)

        XCTAssertEqual(cats.count, 1)
        XCTAssertEqual(cats.first?.breeds?.count, 1)
        XCTAssertEqual(cats.first?.breeds?.first?.name, Constants.breedName)
    }

    private enum Constants {

        static let catID = "ebv"
        static let catURL = "https://cdn2.thecatapi.com/images/ebv.jpg"

        static let breedID = "abys"
        static let breedName = "Abyssinian"
    }
}
