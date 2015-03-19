//
//  TestViewController.swift
//  ios
//
//  Created by Ehsan Asdar on 3/19/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var label: UILabel!
    var course:Course!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = course.title
        teacher.text = course.teacherName
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

