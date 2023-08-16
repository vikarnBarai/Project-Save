//
//  PersistenceManager.swift
//  ProjectSave-CoreData
//
//  Created by Vikarn Barai on 14/08/23.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    private init() {}
    
    static let shared = PersistenceManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProjectDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                debugPrint(storeDescription)
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    @discardableResult
    func saveContext () -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint(nserror)
                return false
            }
            return true
        }
        return false
    }
    
    func fetch<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistenceManager.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {
                return nil
            }
            
            return result
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
    
}
