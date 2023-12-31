//
//  Persistence.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 10.11.23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    enum PreviewFor {
        case contentView
        case coreDataView
    }
    
    static var view: PreviewFor = .contentView

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        switch view {
        case .contentView:
            for _ in 0..<10 {
                let newItem = Item(context: viewContext)
                newItem.timestamp = Date()
            }
        case .coreDataView:
            for _ in 0..<10 {
                let newItem = FruitEntity(context: viewContext)
                newItem.name = "Vuk: \(Date())"
            }
        }
        
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
    
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SwiftUI_Intermediate")
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
