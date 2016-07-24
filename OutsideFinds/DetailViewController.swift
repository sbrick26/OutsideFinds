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
    
    @IBAction func sendPicture(sender: AnyObject) {
        self.photoTakingHelper = PhotoTakingHelper(viewController: self) {(image:UIImage?) in
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


