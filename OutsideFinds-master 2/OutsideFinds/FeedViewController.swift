//
//  FeedViewController.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit
import Parse

var phoneNum = "4697197413"
var lostObject = ""
var state = false
var indexNum = 0
var objectsGlobal: [PFObject] = []


var timer: NSTimer!
var refresher: UIRefreshControl!

class FeedViewController: UIViewController, UITableViewDataSource {
    
    var posts: [Post] = []
    
    func timeRefresh() {
        self.tableview.reloadData()
    }
    
    func refresh() {
        
        posts = []
        getPosts{(success: Bool) in
            
            print("RUNNING GET POSTS")
            if success {
                dispatch_async(dispatch_get_main_queue(),{
                    print("here are the posts \(self.posts)")
                })
            }
            
            
            
        }
        self.tableview.reloadData()
        refresher.endRefreshing()
    }
    
    

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        

        
        setStatusBarBackgroundColor((UIColor(colorLiteralRed: 28/255, green: 228/255, blue: 208/255, alpha: 1)))
                
       

        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.tableview.reloadData()
        })
        
         timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(timeRefresh), userInfo: nil, repeats: true)
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableview.addSubview(refresher)
        refresh()
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "toDetail" {
                print("Table view cell tapped")
                
                // 1
                let indexPath = tableview.indexPathForSelectedRow!
                // 2
                
                let post = posts[indexPath.row]
                // 3
                
                    if post.user.objectId == PFUser.currentUser()!.objectId {
                        print("Current")
                        state = true
                        indexNum = indexPath.row
                    }
                    else {
                        print("Not current user")
                        print("POST USER: \(post.user)")
                        print("CURRENT USER: \(PFUser.currentUser())")
                        state = false
                        
                        
                        
                    }
                               

                
                let detailViewController = segue.destinationViewController as! DetailViewController
                // 4
                detailViewController.post = post
                
            }
        }
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else
        {
            return
        }
        
        statusBar.backgroundColor = color
    }

    
    
    @IBAction func unwindToFeed(segue: UIStoryboardSegue) {
        
    }
    
    
    func getPosts(success: (Bool) -> Void) {
        
        
        let query = PFQuery(className: "Post")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            objectsGlobal = objects!
            print("objects: \(objects)")
            print("error: \(error)")
            
            
            
            if let actualObjects = objects {
                
                
                for object in actualObjects {
                    
                    let currentPost = Post()
                    
                    currentPost.name = object["itemName"] as! String
                    currentPost.description = object["itemDescription"] as! String
                    currentPost.price = object["itemPrice"] as! String
                    phoneNum = currentPost.user["phoneNumber"] as! String //if phone number screws up i think its here
                    lostObject = currentPost.name
                    currentPost.user = object["user"] as! PFUser
                    
                    //object.save()
                    
                    
                    object.saveInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                            var ojId = object.objectId
                            currentPost.postId = ojId!
                        }
                    }
                    
                    
                    
                        
                    
                    
                    self.posts.insert(currentPost, atIndex: 0)
                    print("\(self.posts.count)")
                    
                }
            }
            
           
            
        }
    }
}





   



