//
//  FeedViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse



class FeedViewController: UIViewController, UITableViewDataSource {
    
    var posts: [Post] = []
    

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPosts{(success: Bool) in
            
            print("RUNNING GET POSTS")
            if success {
                dispatch_async(dispatch_get_main_queue(),{
                    print("here are the posts \(self.posts)")
                })
            }
            
            
            
        }

        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.tableview.reloadData()
        })
        
                tableview.dataSource = self

    }
    
    
    
   

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        print("COUNT")
        print(self.posts.count)
        return self.posts.count
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        cell.itemLabel?.text = posts[indexPath.row].name
        cell.descriptionLabel?.text = posts[indexPath.row].description
        cell.priceLabel?.text = "$\(posts[indexPath.row].price)"
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableview.reloadData()
        
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
                    
                    self.posts.insert(currentPost, atIndex: 0)
                    print("\(self.posts.count)")
                    
                }
            }
            
           
            
        }
    }
}


    

    
   



