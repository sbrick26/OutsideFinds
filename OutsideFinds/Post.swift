//
//  Post.swift
//  OutsideFinds
//
//  Created by Swayam Barik on 7/23/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import Foundation
import Parse

class Post{
    
    var name: String = ""
    var description: String = ""
    var price: String = ""
    var claimed: Bool = false
    var user: PFUser = PFUser.currentUser()!
    
}