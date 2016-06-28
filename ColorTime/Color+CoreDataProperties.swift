//
//  Color+CoreDataProperties.swift
//  ColorTime
//
//  Created by Nicholas Laughter on 6/27/16.
//  Copyright © 2016 Nicholas Laughter. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Color {

    @NSManaged var red: NSNumber
    @NSManaged var green: NSNumber
    @NSManaged var blue: NSNumber
    @NSManaged var alpha: NSNumber
    @NSManaged var hex: String
    @NSManaged var timestamp: NSDate

}
