//
//  CourseViewController.swift
//  ios
//
//  Created by Ehsan Asdar on 3/19/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import UIKit

class CourseViewController: UIViewController {
    @IBOutlet var coursename: UITextField!
    @IBOutlet var average: UITextField!
    var course:Course!
    override func viewDidLoad() {
        super.viewDidLoad()
        let floataverage : Float = course.semseters[0].average.grade
        average.text = NSNumberFormatter().stringFromNumber(floataverage)
        coursename.text = course.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

