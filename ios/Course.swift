//
//  Course.swift
//  ios
//
//  Created by Ehsan Asdar on 3/5/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import CoreData
@objc(Course)
class Course: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var teacherName: String
    @NSManaged var courseId: String
    @NSManaged var semesters: NSSet
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title:String,teacherName:String,courseId:String,semseterss:[Semester]) -> Course {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: moc) as Course
        newItem.title = title
        newItem.teacherName = teacherName
        newItem.courseId = courseId
        var set = NSSet(array:semseterss)
        newItem.semesters = set
        return newItem
    }
}