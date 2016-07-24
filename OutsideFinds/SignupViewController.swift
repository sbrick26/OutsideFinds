//
//  LoginViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {
    
    
    
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameField.layer.cornerRadius = 10;
        signUpButton.layer.cornerRadius = 25;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpPressed(sender: UIButton) // This is the button that the user pressed to login/signup
    {
        if usernameField.text != "" && phoneNumberField.text != "" && firstNameField.text != "" && lastNameField.text != "" && passwordField.text != "" && emailField.text != "" {
            
            
            
            var user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            user.email = emailField.text
            user["phoneNumber"] = phoneNumberField.text
            user["firstName"] = firstNameField.text
            user["lastName"] = lastNameField.text
            // other fields can be set just like with PFObject
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again. This error comment can be changed to be more accurate. I think its called also when email isnt in correct email form (xxx@xxx.com), but the comment doesnt sugges that so i would change that.
                    let alert = UIAlertController(title: "oops", message: "Somethign went wrong, try different information...", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    print("UGH")
                } else {
                    // Hooray! Let them use the app now.
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Create View Controller") // again change to your view
                    self.showViewController(vc as! CreateViewController, sender: vc) // change again
                    print("YES")
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




