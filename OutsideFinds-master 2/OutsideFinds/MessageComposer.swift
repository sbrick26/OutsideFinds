//
//  MessageComposer.swift
//  vibe
//
//  Created by Randy Perecman on 7/21/16.
//  Copyright © 2016 OnMilwaukee. All rights reserved.
//
import Foundation
import MessageUI

var storedImage = UIPasteboard.generalPasteboard().image


let textMessageRecipients = ["215-431-3030"] // for pre-populating the recipients list (optional, depending on your needs)

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
   
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        var messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = textMessageRecipients
 //       UIPasteboard.generalPasteboard().image = itemImage
//       storedImage = UIPasteboard.generalPasteboard().image
//    
//        
//        var pasteboard = UIPasteboard.generalPasteboard()
//        pasteboard.image = itemImage
        
        let imgData:NSData = UIImagePNGRepresentation(itemImage)!;
        let dataString = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        func getDocumentsDirectory() -> NSString {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
        
        if let image = UIImage(named: "example.png") {
            if let data = UIImagePNGRepresentation(image) {
                let filename = getDocumentsDirectory().stringByAppendingPathComponent("savedImage.png")
                data.writeToFile(filename, atomically: true)
            }
        }
        
       
        messageComposeVC.addAttachmentData(imgData, typeIdentifier: "image/png", filename: "savedImage.png")
         messageComposeVC.body = "Hey! I think I found your \(lostObject), check it out!"
        
        return messageComposeVC
        
            }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}