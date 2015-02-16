//
//  DataStructs.swift
//  ios
//
//  Created by Ehsan Asdar on 2/15/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
class GradeValue{
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
//    init(fromLetter gradeletter:String){
//        
//    }
}
struct Cycle{
    var index:Int
    var average:GradeValue
}
struct Semester{
    var index:Int
    var average:GradeValue
    var examGrade:GradeValue
    var cycles:[Cycle]
}
struct Course{
    var title:String
    var teacherName:String
    var courseId:String
    var semseters:[Semester]
}