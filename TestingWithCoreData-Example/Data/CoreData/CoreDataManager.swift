//
//  CoreDataManager.swift
//  CoreDataMigration-Example
//
//  Created by William Boles on 11/09/2017.
//  Copyright © 2017 William Boles. All rights reserved.
//

import Foundation
import CoreData

protocol NSPersistentContainerProtocol {
    
    var viewContext: NSManagedObjectContext { get }
    
    func newBackgroundContext() -> NSManagedObjectContext
    func loadPersistentStores(completionHandler block: @escaping (NSPersistentStoreDescription, Error?) -> Swift.Void)
}

protocol NSManagedObjectContextProtocol: class {
    func performAndWait(_ block: () -> Swift.Void)
    func save() throws
    func delete(_ object: NSManagedObject)
}

extension NSManagedObjectContext: NSManagedObjectContextProtocol{
}

extension NSPersistentContainer: NSPersistentContainerProtocol {
}

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainerProtocol! = {
        
        return NSPersistentContainer(name: "TestingWithCoreData_Example")
    }()
    
    lazy var backgroundContext: NSManagedObjectContextProtocol = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    // MARK: - Singleton
    
    static let shared = CoreDataManager()
    
    // MARK: - SetUp
    
    func setup(completion: (() -> Void)?) {
        
        loadPersistentStore {
            completion?()
        }
    }
    
    // MARK: - Loading
    
    private func loadPersistentStore(completion: @escaping () -> Void) {
        //handle data migration here
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
            
            completion()
        }
    }
}

