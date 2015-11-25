//
//  Parser.swift
//  ios
//
//  Created by Ehsan Asdar on 2/14/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import Kanna

class Parser{
    class func parseAverages(html:String)->[Course] {
        let parser = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding)
        let metadataTable = parser!.body!.css("#finalTablebotLeft1")[0].css("#tableHeaderTable")[0]
        let metadataRows = metadataTable.css("tr")
        let gradeTable = parser!.body!.css("#finalTablebottomRight1")[0].css("#tableHeaderTable")[0]
        let gradeRows = gradeTable.css("tr")
        var courses:Array<Course> = []
        for i in 2 ... metadataRows.count - 1 {
            let course = parseCourse(metadataRows[i], graderow: gradeRows[i])
            courses.append(course)
        }
        return courses
    }
    
    class func parseCourse(metadatarow: htmlNodePtr?,graderow: XMLElement?)->Course{
        let metadataCells = metadatarow!.css("td")
        let gradeCells = graderow!.css("td")
        
        let courseID = metadataCells[0].text
        let teacherCell = metadataCells[2].css("a")
        let titleCell = metadataCells[3]
        
        var semesters:Array<Semester> = []
        for i in 0...2 { // Number of semesters (unfortunately hardcoded)
            let celloffset = i * (5) // 5 = cycles per semester + exam + semester average
            var cycleCells:Array<XMLElement> = []
            for j in 0...2  { // Number of semesters again
                cycleCells.append(gradeCells[celloffset+j])
            }
            let examCell = gradeCells[celloffset+3]
            let semAvgCell = gradeCells[celloffset+4]
            semesters.append(parseSemester(cycleCells, examcell: examCell, avgcell:semAvgCell, index:i))
        }
        let course = Course(title: titleCell.text!, teacherName: teacherCell.text!, courseId: courseID!, semestersIn: semesters)
        return course
    }
    
    class func parseSemester(cyclecells:[XMLElement], examcell:XMLElement, avgcell:XMLElement, index:Int) -> Semester {
        var cycles:[Cycle] = []
        for i in 0...2 {
            cycles.append(parseCycle(cyclecells[i], index: i))
        }
        let examlink = examcell.css("a")[0]
        let examgrade = GradeValue(fromString: examlink.text!)
        var cyclesCompleted = Float(0)
        var sum = Float(0)
        for i in 0...2{
            if (cycles[i].average.grade != -1){
                cyclesCompleted++
                sum += cycles[i].average.grade
            }
        }
        if(examgrade.grade != -1){
            cyclesCompleted++
            sum+=examgrade.grade
        }
        let semAverage = GradeValue(gradefloat:(sum/cyclesCompleted))
        let semesterout = Semester(index: index, average: semAverage, examGrade: examgrade, cyclesIn: cycles)
        return semesterout
    }
    
    class func parseCycle(cycle:XMLElement, index:Int)->Cycle{
        let link = cycle.css("a")[0]
        let average = GradeValue(fromString:link.text!)
        let cycle = Cycle(index: index, average: average)
        return cycle
    }
}