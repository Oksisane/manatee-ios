//
//  FirstViewController.swift
//  ios
//
//  Created by Ehsan Asdar on 12/13/14.
//  Copyright (c) 2014 Ehsan Asdar. All rights reserved.
//

import UIKit
import CoreData

var courses = [Course]()
var logTableView = UITableView(frame: CGRectZero, style: .Plain)

let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
class FirstViewController: UIViewController,UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        println(managedObjectContext)
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: managedObjectContext!) as Course
        newItem.title = "APUSH"
        newItem.teacherName = "Flowers"
        // Do any additional setup after loading the view, typically from a nib.
        if let moc = managedObjectContext {
            
            // Now that the view loaded, we have a frame for the view, which will be (0,0,screen width, screen height)
            // This is a good size for the table view as well, so let's use that
            // The only adjust we'll make is to move it down by 20 pixels, and reduce the size by 20 pixels
            // in order to account for the status bar
            
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
            populateCourses()
        }
    }
    func populateCourses() {
        let fetchRequest = NSFetchRequest(entityName: "Course")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Course] {
            courses = fetchResults
        }
    }
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as UITableViewCell
        let course = courses[indexPath.row]
        cell.textLabel?.text = course.title
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

