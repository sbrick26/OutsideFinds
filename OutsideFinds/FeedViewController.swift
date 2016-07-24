//
//  FeedViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse

var posts: [Post] = []

class FeedViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getPosts{(success: Bool) in
            if success {
                dispatch_async(dispatch_get_main_queue(),{
                    print("here are the posts \(posts)")
                })
            }
        

        
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    
    
    func getPosts(success: (Bool) -> Void) {
        let query = PFQuery(className: "Post")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        
            print("objects: \(objects)")
            print("error: \(error)")
            
            
            
            if let actualObjects = objects {
                
                
                for object in actualObjects {
                    
                    let currentPost = Post()
                    
                    currentPost.name = object["itemName"] as! String
                    currentPost.description = object["itemDescription"] as! String
                    currentPost.price = object["itemPrice"] as! String
                    
                    posts.append(currentPost)
                    
                }
            }
            
        }
    }
}


