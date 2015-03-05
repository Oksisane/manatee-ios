//
//  Semester.swift
//  ios
//
//  Created by Ehsan Asdar on 3/5/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import CoreData
@objc(Semester)
class Semester: NSManagedObject {
    
    @NSManaged var index: NSNumber
    @NSManaged var average: NSManagedObject
    @NSManaged var examGrade: NSManagedObject
    @NSManaged var cycles: NSSet
    class func createInManagedObjectContext(moc: NSManagedObjectContext, index:Int,average:GradeValue,examGrade:GradeValue,cycles:[Cycle]) -> Semester {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Semester", inManagedObjectContext: moc) as Semester
        newItem.index = index
        newItem.average = average
        newItem.examGrade = examGrade
        var set = NSSet(array:cycles)
        newItem.cycles = set
        return newItem
    }
    
}
