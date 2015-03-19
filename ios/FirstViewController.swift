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
var logTableView = UITableView(frame: CGRectZero, style: .Plain)

class FirstViewController: UIViewController,UITableViewDataSource {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        var connection = appDelegate.connection!
        connection.readWithBlock({
            (transaction: YapDatabaseReadTransaction!) in
            var message : [Course] = (transaction.objectForKey("courses", inCollection: "courseinfo")) as [Course]
            courses = message
            // Store the full frame in a temporary variable
            var viewFrame = self.view.frame
            
            // Adjust it down by 20 points
            viewFrame.origin.y += 20
            
            // Reduce the total height by 20 points
            viewFrame.size.height -= 20
            
            // Set the logTableview's frame to equal our temporary variable with the full size of the view
            // adjusted to account for the status bar height
            logTableView.frame = viewFrame
            
            // Add the table view to this view controller's view
            self.view.addSubview(logTableView)
            
            // Here, we tell the table view that we intend to use a cell we're going to call "LogCell"
            // This will be associated with the standard UITableViewCell class for now
            logTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CourseCell")
            
            // This tells the table view that it should get it's data from this class, ViewController
            logTableView.dataSource = self
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as UITableViewCell
        let course = courses[indexPath.row]
        let newView:TestViewController = TestViewController(nibName:"TestView",bundle:nil)
        newView.course = course
        cell.contentView.addSubview(newView.view)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get the row data for the selected row
        var rowData:Course = courses[indexPath.row]
        var alert: UIAlertView = UIAlertView()
        alert.title = rowData.title
        alert.message = String(format: "%.2f",rowData.semseters[0].average.grade)
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

