//
//  Color.swift
//  ColorTime
//
//  Created by Nicholas Laughter on 6/27/16.
//  Copyright © 2016 Nicholas Laughter. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Color: NSManagedObject {
    
    static let typeKey = "Color"
    static let timestampKey = "timestamp"
    
    convenience init(color: UIColor, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Color", inManagedObjectContext: context) else { fatalError("Could not create entity from moc") }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.timestamp = NSDate()
        guard let rgb = color.rgb() else { return }
        self.red = rgb.red
        self.blue = rgb.blue
        self.green = rgb.green
        self.alpha = rgb.alpha
        self.hex = color.toHexString()
    }
    
    var color: UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
}
