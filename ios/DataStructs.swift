//
//  DataStructs.swift
//  ios
//
//  Created by Ehsan Asdar on 2/15/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
class GradeValue: NSObject,NSCoding{
    var grade:Float = -1

    init (gradefloat:Float){
        grade = gradefloat
    }
    init (fromInt gradeint:Int){
        grade = Float(gradeint)
    }
    init(fromString gradestring:String){
        grade = (gradestring as NSString).floatValue
        if (grade == 0){
            grade = -1
        }
    }
    required init(coder aDecoder: NSCoder) {
        self.grade = aDecoder.decodeFloatForKey("grade")
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeFloat(grade, forKey: "grade")
    }
}
class Cycle: NSObject,NSCoding{
    var index:Int32
    var average:GradeValue
    init(index:Int,average:GradeValue){
        self.index = Int32(index)
        self.average = average
    }
    required init(coder aDecoder: NSCoder) {
        self.index = aDecoder.decodeInt32ForKey("index")
        self.average = aDecoder.decodeObjectForKey("average") as GradeValue
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt32(self.index, forKey:"index")
        aCoder.encodeObject(self.average, forKey:"average")
    }
}
class Semester: NSObject,NSCoding{
    var index:Int32
    var average:GradeValue
    var examGrade:GradeValue
    var cycles:[Cycle]
    init(index:Int,average:GradeValue,examGrade:GradeValue, cyclesIn:[Cycle] ){
        self.index = Int32(index)
        self.average = average
        self.examGrade = examGrade
        self.cycles = cyclesIn
    }

    required init(coder aDecoder: NSCoder) {
        self.index = aDecoder.decodeInt32ForKey("index")
        self.average = aDecoder.decodeObjectForKey("average") as GradeValue
        self.examGrade = aDecoder.decodeObjectForKey("examGrade") as GradeValue
        self.cycles = aDecoder.decodeObjectForKey("cycles") as [Cycle]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt32(self.index, forKey:"index")
        aCoder.encodeObject(self.average, forKey:"average")
        aCoder.encodeObject(self.examGrade, forKey:"examGrade")
        aCoder.encodeObject(self.cycles, forKey:"cycles")
        
    }
}
class Course: NSObject,NSCoding{
    var title:String
    var teacherName:String
    var courseId:String
    var semseters:[Semester]
    
    init(title:String,teacherName:String,courseId:String, semestersIn:[Semester] ){
        self.title = title
        self.teacherName = teacherName
        self.courseId = courseId
        self.semseters = semestersIn
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as NSString
        self.teacherName = aDecoder.decodeObjectForKey("teacherName") as NSString
        self.courseId = aDecoder.decodeObjectForKey("courseId") as NSString
        self.semseters = aDecoder.decodeObjectForKey("semesters") as [Semester]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey:"title")
        aCoder.encodeObject(self.teacherName, forKey:"teacherName")
        aCoder.encodeObject(self.courseId, forKey:"courseId")
        aCoder.encodeObject(self.semseters, forKey:"semseters")

    }

}