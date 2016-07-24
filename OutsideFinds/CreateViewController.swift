//
//  CreateViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse



class CreateViewController: UIViewController {
    
    

    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var bountyField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createPressed(sender: UIButton) {
        if itemNameField.text != "" && bountyField.text != "" && descriptionView.text != "" {
            
            let newPost = PFObject(className: "Post")
            newPost["itemName"] = itemNameField.text
            newPost["itemDescription"] = descriptionView.text
            newPost["itemPrice"] = bountyField.text
            newPost["user"] = PFUser.currentUser()
            newPost["claimed"] = false
            
            
            newPost.saveInBackgroundWithBlock { (success: Bool, erro: NSError?) -> Void in
                if success {
                    print("Object Saved!!")
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Feed View Controller") // again change to your view
                    self.showViewController(vc as! FeedViewController, sender: vc) // change again
                    
                }
                else {
                    print("Error!!")
                }
            
            
            
            
        }
        
    }
    

}
}
