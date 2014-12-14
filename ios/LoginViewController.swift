//
//  LoginViewController.swift
//  ios
//
//  Created by Ehsan Asdar on 12/13/14.
//  Copyright (c) 2014 Ehsan Asdar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var labelTextField: UILabel!
    
    @IBAction func verifyLogin(sender: AnyObject) {
        var usr = "secret"
        var pw = "password"
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if (usernameTextField.text == usr && passwordTextField.text == pw){
            labelTextField.text = "Login Successful"
            usernameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            labelTextField.textColor = UIColor.greenColor()
            let firstViewController:FirstViewController = FirstViewController()
            if let resultController = storyboard.instantiateViewControllerWithIdentifier("Grade") as? FirstViewController {
                presentViewController(resultController, animated: true, completion: nil)
            }
        }
        else{
            labelTextField.text = "Login Unsucessful"
            usernameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            labelTextField.textColor = UIColor.redColor()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

