//
//  ColorsDataManager.swift
//  TestingWithCoreData-Example
//
//  Created by William Boles on 09/03/2018.
//  Copyright © 2018 William Boles. All rights reserved.
//

import UIKit
import CoreData

class ColorsDataManager {

    let backgroundContext: NSManagedObjectContextProtocol
    
    // MARK: - Init
    
    init(backgroundContext: NSManagedObjectContextProtocol = CoreDataManager.shared.backgroundContext) {
        self.backgroundContext = backgroundContext
    }
    
    // MARK: - Create
    
    func createColor() {
        backgroundContext.performAndWait {
            
            if let backgroundContext = backgroundContext as? NSManagedObjectContext {
                let color = NSEntityDescription.insertNewObject(forEntityName: Color.className, into: backgroundContext) as! Color
                color.hex = UIColor.random.hexString
                color.dateCreated = Date()
            }
            
            try! backgroundContext.save()
        }
    }
    
    // MARK: - Deletion
    
    func deleteColor(color: Color) {
        backgroundContext.performAndWait {
            backgroundContext.delete(color)
            
            try! backgroundContext.save()
        }
    }
}
