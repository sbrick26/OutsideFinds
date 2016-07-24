//
//  DetailViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse

var thisPost = PFObject(className: "Post")
var thisUser =  thisPost["user"]



var itemImage: UIImage = UIImage(named: "Feed")!

class DetailViewController: UIViewController {
    var post: Post?
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var gotitButton: UIButton!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var foundButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        
        print("HEY")
        
        foundButton.titleLabel?.text = "Found This Item!"

        
        setStatusBarBackgroundColor((UIColor(colorLiteralRed: 28/255, green: 228/255, blue: 208/255, alpha: 1)))

        // Do any additional setup after loading the view.
        modalView.hidden = true
        
        foundButton.layer.cornerRadius = 25
        
       
        
//        if post!.user == PFUser.currentUser()! {
//            print("Current")
//        }
//        else {
//            print("Not current user")
//        }
        if state == true {
            foundButton.setTitle("I Recieved the Item", forState: UIControlState.Normal)
            foundButton.setTitle("I Recieved the Item", forState: UIControlState.Highlighted)
            
        }
        
        
    
    }
    func sendMessageCalled() {
        //ADD CODE HERE RANDAL
        // Make sure the device can send text messages
        if (self.messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            
            
                let messageComposeVC = self.messageComposer.configuredMessageComposeViewController()
            
                presentViewController(messageComposeVC, animated: true, completion: nil)
            
            
            
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            
        } else {
            // Let the user know if his/her device isn't able to send text messages
            // let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            //  errorAlert.show()
            print("YOooooooo")
        }
    }

    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else
        {
            return
        }
        
        statusBar.backgroundColor = color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        nameLabel.text! = (post?.name)!
        priceLabel.text! = "$" + (post?.price)!
        descriptionView.text! = (post?.description)!
        
        modalView.layer.cornerRadius = 15
        gotitButton.layer.cornerRadius = 20
    }
    
    var photoTakingHelper: PhotoTakingHelper!
    let messageComposer = MessageComposer()
    
    @IBAction func sendPicture(sender: AnyObject) {
        
        modalView.hidden = false
            UIView.animateWithDuration(0.5, animations: {
            self.modalView.center.y -= self.view.bounds.height - 650
                
                
            
                
                
            })
        
        
        
        
        }
    
    @IBAction func sendIt(sender: AnyObject) {
        if foundButton.titleLabel!.text == "Found This Item" {
        self.photoTakingHelper = PhotoTakingHelper(viewController: self) {(image:UIImage?) in
            guard let image = image else{
                return
            }
            itemImage = image
            self.sendMessageCalled()
        }

    }
        else {
            // delete post
            print("DELETE")
            
            
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


