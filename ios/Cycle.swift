//
//  Cycle.swift
//  ios
//
//  Created by Ehsan Asdar on 3/5/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import CoreData

@objc(Cycle)
class Cycle: NSManagedObject {
    
    @NSManaged var index: NSNumber
    @NSManaged var average: GradeValue
    class func createInManagedObjectContext(moc: NSManagedObjectContext, index:Int,average:GradeValue) -> Cycle {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Cycle", inManagedObjectContext: moc) as Cycle
        newItem.index = index
        newItem.average = average
        return newItem
    }
}

