//
//  Message.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/12/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

struct Messages {
    let keyMess:String!
    let type:String!
    let fromId:String!
    let toId:String!
    let text:String!
    let urlImage:String!
    let timestamp:NSNumber!
    let imageWidth:NSNumber!
    let imageHeight:NSNumber!
    
    init() {
        self.keyMess = ""
        self.fromId = ""
        self.toId = ""
        self.text = ""
        self.type = "TEXT"
        self.urlImage = ""
        self.timestamp = 0
        self.imageWidth = 0
        self.imageHeight = 0
    }
    
    init(key:String , snapshot: Dictionary<String,AnyObject>) {
        self.keyMess = key
        self.type = snapshot["type"] as! String
        self.fromId = snapshot["fromId"] as! String
        self.toId = snapshot["toId"] as! String
        self.timestamp = snapshot["timestamp"] as! NSNumber!
        self.text = snapshot["text"] as? String
        self.urlImage = snapshot["urlImage"] as? String
        self.imageWidth = snapshot["imageWidth"] as? NSNumber
        self.imageHeight = snapshot["imageHeight"] as? NSNumber
    }
}

