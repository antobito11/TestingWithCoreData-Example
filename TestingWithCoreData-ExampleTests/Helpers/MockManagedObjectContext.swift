//
//  MockManagedObjectContext.swift
//  TestingWithCoreData-ExampleTests
//
//  Created by Gomez, Antonio (Developer) on 05/04/2018.
//  Copyright © 2018 William Boles. All rights reserved.
//

import Foundation
import CoreData
@testable import TestingWithCoreData_Example

class MockManagedObjectContext: NSManagedObjectContextProtocol {
    
    var performAndWaitCalled = false
    var saveCalled = false
    var invokedDeleteObject: NSManagedObject?

    func performAndWait(_ block: () -> Void) {
        
        performAndWaitCalled = true
        
        block()
    }
    
    func save() throws {
        
        saveCalled = true
    }
    
    func delete(_ object: NSManagedObject) {
        invokedDeleteObject = object
    }
}
