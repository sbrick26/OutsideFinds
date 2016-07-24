//
//  DetailViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController {
    var post: Post?

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    func sendMessageCalled() {
        //ADD CODE HERE RANDAL
        // Make sure the device can send text messages
        if (self.messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = self.messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            // let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            //  errorAlert.show()
            print("YOooooooo")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        nameLabel.text! = (post?.name)!
        priceLabel.text! = (post?.price)!
        descriptionView.text! = (post?.description)!
    }
    
    var photoTakingHelper: PhotoTakingHelper!
    let messageComposer = MessageComposer()
    
    @IBAction func sendPicture(sender: AnyObject) {
        self.photoTakingHelper = PhotoTakingHelper(viewController: self) {(image:UIImage?) in
            guard let image = image else{
                return
            }
            self.sendMessageCalled()
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

