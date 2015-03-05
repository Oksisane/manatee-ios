//
//  LoginViewController.swift
//  ios
//
//  Created by Ehsan Asdar on 12/13/14.
//  Copyright (c) 2014 Ehsan Asdar. All rights reserved.
//

import UIKit
import Foundation
class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var labelTextField: UILabel!
    
    @IBAction func verifyLogin(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        Retriever.login(usernameTextField.text, password: passwordTextField.text){
            if ($0 != "ERROR"){
                Retriever.getCourses($0!){
                    println($0)
                }
                self.usernameTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.labelTextField.textColor = UIColor.greenColor()
                let firstViewController:FirstViewController = FirstViewController()
                if let resultController = storyboard.instantiateViewControllerWithIdentifier("Grade") as? FirstViewController
                {
                    self.presentViewController(resultController, animated: true, completion: nil)
                }
                
            }
            else{
                self.labelTextField.text = "Login Unsucessful"
                self.usernameTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                
                self.labelTextField.textColor = UIColor.redColor()
            }

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.secureTextEntry = true;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

