//
//  Persistence.swift
//  Hatche
//
//  Created by student on 05/05/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        var newItem = Equipment(context: viewContext)
        newItem.name = "Zelazny miecz"
        newItem.image = "Iron_Sword"
        newItem.slot_type = "Hands"
        newItem.score = 100
        
        newItem = Equipment(context: viewContext)
        newItem.name = "Diamentowy miecz"
        newItem.image = "Diamond_Sword"
        newItem.slot_type = "Hands"
        newItem.score = 300
        
        var newItem4 = Hatch(context: viewContext)
        newItem4.type_name = "Andzrej"
        newItem4.score = 1000
        newItem4.image = "1"
        
        var newItem2 = Hatch(context: viewContext)
        newItem2.type_name = "Marcin"
        newItem2.score = 200
        newItem2.image = "16"
        
        var newItem3 = Hatch(context: viewContext)
        newItem3.type_name = "Julka kulka"
        newItem3.score = 2137
        newItem3.image = "18"
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Hatche")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
