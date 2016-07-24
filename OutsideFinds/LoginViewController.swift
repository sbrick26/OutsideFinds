//
//  LoginViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(sender: UIButton) {
    
        if usernameField.text != "" && passwordField.text != "" {
        
    PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
    (user: PFUser?, error: NSError?) -> Void in
    if user != nil {
    // Do stuff after successful login.
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") // again change to your view
        self.showViewController(vc as! UITabBarController, sender: vc) // change again

    } else {
    // The login failed. Check error to see why.
        let alert = UIAlertController(title: "Oops", message: "Something went wrong, try different information.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
            }
        }
            else {
                let alert = UIAlertController(title: "Sorry", message: "You need to fill out every field.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
    }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


