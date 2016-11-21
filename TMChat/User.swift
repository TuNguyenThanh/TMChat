//
//  User.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/29/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import Foundation

struct User {
    let uid:String!
    let name:String!
    let email:String!
    let phone:String!
    let avatarURL:String!
    let online:Bool!
    
    init() {
        self.uid = ""
        self.name = ""
        self.email = ""
        self.phone = ""
        self.avatarURL = ""
        self.online = false
    }
    
    init(key: String , snapshot: Dictionary<String,AnyObject>) {
        self.uid = key
        self.name = snapshot["name"] as! String
        self.email = snapshot["email"] as! String
        self.phone = snapshot["numberPhone"] as! String
        self.avatarURL = snapshot["avatarURL"] as! String
        self.online = snapshot["online"] as! Bool
    }
}
