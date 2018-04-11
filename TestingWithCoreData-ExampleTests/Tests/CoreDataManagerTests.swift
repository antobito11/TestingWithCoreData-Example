//
//  CoreDataManagerTests.swift
//  TestingWithCoreData-ExampleTests
//
//  Created by William Boles on 12/03/2018.
//  Copyright © 2018 William Boles. All rights reserved.
//

import XCTest
import CoreData
@testable import TestingWithCoreData_Example

class CoreDataManagerTests: XCTestCase {
    
    // MARK: Properties
    
    var sut: CoreDataManager!
    var mockPersistentContainer: MockPersistentContainer!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = CoreDataManager()
        mockPersistentContainer = MockPersistentContainer()
        sut.persistentContainer = mockPersistentContainer
    }
    
    // MARK: - Tests
    
    // MARK: Setup
    
    func test_setup_completionCalled() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup {
            setupExpectation.fulfill()
        }
        
        wait(for: [setupExpectation], timeout: 1.0)
    }
    
    func test_setup_persistentStoreCreated() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup {
            setupExpectation.fulfill()
        }
        
        // We could potentially get rid of the expectation and assert the completion in a different way
        waitForExpectations(timeout: 1.0) { [weak self] (_) in
            XCTAssertEqual(self?.mockPersistentContainer.loadPersistentStoresCalled, true)
        }
    }
    
    // MARK: Contexts
    
    func test_backgroundContext() {
        let setupExpectation = expectation(description: "set up completion called")
        
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        mockPersistentContainer.stubManagedObjectContext = backgroundContext
        
        sut.setup{
            XCTAssert(self.sut.backgroundContext === backgroundContext)
            setupExpectation.fulfill()
        }
        
        wait(for: [setupExpectation], timeout: 1.0)
    }
    
    func test_mainContext() {
        let setupExpectation = expectation(description: "set up completion called")
        
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mockPersistentContainer.viewContext = mainContext
        
        sut.setup {
            XCTAssertEqual(self.sut.mainContext, mainContext)
            setupExpectation.fulfill()
        }
        
        wait(for: [setupExpectation], timeout: 1.0)
    }
}
