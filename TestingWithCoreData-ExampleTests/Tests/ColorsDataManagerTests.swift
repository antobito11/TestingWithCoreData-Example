//
//  ColorsDataManagerTests.swift
//  TestingWithCoreData-ExampleTests
//
//  Created by William Boles on 08/03/2018.
//  Copyright © 2018 William Boles. All rights reserved.
//

import XCTest
import CoreData
@testable import TestingWithCoreData_Example

class ColorsDataManagerTests: XCTestCase {
    
    // MARK: Properties
    
    var sut: ColorsDataManager!
    var backgroundContext: MockManagedObjectContext!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        backgroundContext = MockManagedObjectContext()
        
        sut = ColorsDataManager(backgroundContext: backgroundContext)
    }
    
    // MARK: - Tests
    
    // MARK: Init
    
    func test_init_contexts() {
        XCTAssert(sut.backgroundContext === backgroundContext)
    }
    
    // MARK: Create
    
    func test_createColor_colorCreated() {
        
        sut.createColor()
        
        XCTAssertTrue(backgroundContext.performAndWaitCalled)
        XCTAssertTrue(backgroundContext.saveCalled)
    }
    
    // MARK: Deletion
    
    func test_deleteColor_colorDeleted() {
        
        let colorB = Color()
        
        sut.deleteColor(color: colorB)
        
        XCTAssertTrue(backgroundContext.performAndWaitCalled)
        XCTAssertTrue(backgroundContext.saveCalled)
        XCTAssertEqual(backgroundContext.invokedDeleteObject, colorB)
    }
}
