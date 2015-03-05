//
//  GradeValue.swift
//  ios
//
//  Created by Ehsan Asdar on 3/5/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import CoreData
@objc(GradeValue)
class GradeValue: NSManagedObject {
    
    @NSManaged var grade: NSNumber
    class func createInManagedObjectContext(moc: NSManagedObjectContext, grade:Float) -> GradeValue {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("GradeValue", inManagedObjectContext: moc) as GradeValue
        newItem.grade = grade
        return newItem
    }
    class func createInManagedObjectContext(moc: NSManagedObjectContext, grade:Int) -> GradeValue {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("GradeValue", inManagedObjectContext: moc) as GradeValue
        newItem.grade = Float(grade)
        return newItem
    }
    class func createInManagedObjectContext(moc: NSManagedObjectContext, grade:String) -> GradeValue {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("GradeValue", inManagedObjectContext: moc) as GradeValue
        var gradeconv = (grade as NSString).floatValue
        if (gradeconv == 0){
            gradeconv = -1
        }
        newItem.grade = gradeconv
        return newItem
    }
    
    
}
