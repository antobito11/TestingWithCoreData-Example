//
//  MockPersistentContainer.swift
//  TestingWithCoreData-ExampleTests
//
//  Created by Gomez, Antonio (Developer) on 05/04/2018.
//  Copyright © 2018 William Boles. All rights reserved.
//

import Foundation
import CoreData
@testable import TestingWithCoreData_Example

class MockPersistentContainer: NSPersistentContainerProtocol {
    var viewContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    var stubManagedObjectContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    var newBackgroundContextCalled = false
    var loadPersistentStoresCalled = false
    var stubError: Error?

    func newBackgroundContext() -> NSManagedObjectContext {
        
        newBackgroundContextCalled = true
        
        return stubManagedObjectContext
    }
    
    func loadPersistentStores(completionHandler block: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        
        loadPersistentStoresCalled = true
        block(NSPersistentStoreDescription(), stubError)
    }
}
