//
//  FirstViewController.swift
//  ios
//
//  Created by Ehsan Asdar on 12/13/14.
//  Copyright (c) 2014 Ehsan Asdar. All rights reserved.
//

import UIKit
import YapDatabase
var courses = [Course]()
class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let courseCellIdentifier = "CourseCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        var connection = appDelegate.connection!
        connection.readWithBlock({
            (transaction: YapDatabaseReadTransaction!) in
            var message : [Course] = (transaction.objectForKey("courses", inCollection: "courseinfo")) as! [Course]
            courses = message
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return courseCellAtIndexPath(indexPath)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func courseCellAtIndexPath(indexPath:NSIndexPath) -> CourseCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(courseCellIdentifier) as! CourseCell
        let localcourse = courses[indexPath.row] as Course!
        cell.titleLabel.text = localcourse.title
        return cell
    }
    func configureTableView() {
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 160.0
    }

}

