//
//  CourseCell.swift
//  ios
//
//  Created by Ehsan Asdar on 3/19/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import UIKit
import YapDatabase

class CourseCell:UITableViewCell,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var gradeTable: UITableView!
    var clearTable:Bool = false
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureTableView()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        self.gradeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.gradeTable.delegate = self
        self.gradeTable.dataSource = self
    }
    override func prepareForReuse() {
        titleLabel.text = ""
        clearTable = true
        gradeTable.reloadData()
        clearTable = false
        gradeTable.reloadData()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:SemesterCell = self.gradeTable.dequeueReusableCellWithIdentifier("SemesterCell") as! SemesterCell
        for course in courses{
            if (titleLabel.text == course.title){
                print("Loading " + course.title + " with values " + course.semseters[indexPath.row].cycles[0].average.grade.description)
                cell.GradeOne.text = Int(course.semseters[indexPath.row].cycles[0].average.grade).description
            }
        }
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (clearTable){
            return 0
        }
        return 2
    }
    
    func configureTableView() {
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 160.0
    }
}
