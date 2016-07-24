//
//  LaunchScreenViewController.swift
//  OutsideFinds
//
//  Created by Anusha Venkatesan on 7/24/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    //
    //  ViewController.swift
    //  Animations
    //
    //  Created by Rob Percival on 27/02/2015.
    //  Copyright (c) 2015 Appfish. All rights reserved.
    //
    
        
        var counter = 1
        
        var timer = NSTimer()
        
        var isAnimating = true
        
        @IBOutlet var alienImage: UIImageView!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
            if isAnimating == true {
                
                timer.invalidate()
                
                isAnimating = false
                
            } else {
                
                timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
                
                isAnimating = true
                
            }
            
        }
        
        func doAnimation() {
            
            if counter == 5 {
                
                counter = 1
                
            } else {
                
                counter++
                
            }
            
            alienImage.image = UIImage(named: "frame\(counter).png")
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        /*
         override func viewDidLayoutSubviews() {
         
         alienImage.frame = CGRectMake(100, 20, 0, 0)
         
         }
         
         override func viewDidAppear(animated: Bool) {
         
         UIView.animateWithDuration(1, animations: { () -> Void in
         
         self.alienImage.frame = CGRectMake(100, 20, 100, 200)
         
         })
         
         
         }
         
         */
        
        
        
        
        
        
        
        
}