//
//  ColorController.swift
//  ColorTime
//
//  Created by Nicholas Laughter on 6/27/16.
//  Copyright © 2016 Nicholas Laughter. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ColorController {
    
    static let shared = ColorController()
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let moc = Stack.sharedStack.managedObjectContext
        let request = NSFetchRequest(entityName: Color.typeKey)
        let sortDescriptor = NSSortDescriptor(key: Color.timestampKey, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
    }
    
    func createColor() {
        _ = Color(color: UIColor.randomColor())
        saveToPersistentStore()
    }
    
    func deleteColor(color: Color) {
        color.managedObjectContext?.deleteObject(color)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch let error as NSError {
            fatalError("Could not save - \(error.localizedDescription)")
        }
    }
}