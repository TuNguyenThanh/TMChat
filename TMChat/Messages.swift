//
//  Message.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/12/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import Foundation

struct Messages {
    let keyMess:String!
    let fromId:String!
    let toId:String!
    let text:String!
    let timestamp:NSNumber!
    
    init() {
        self.keyMess = ""
        self.fromId = ""
        self.toId = ""
        self.text = ""
        self.timestamp = 0
    }
    
    init(keyMess:String, fromId:String, toId:String, text:String) {
        self.keyMess = keyMess
        self.fromId = fromId
        self.toId = toId
        self.text = text
        self.timestamp = 0
    }
    
    init(keyMess:String , snapshot: Dictionary<String,AnyObject>) {
        self.keyMess = keyMess
        self.fromId = snapshot["fromId"] as! String
        self.toId = snapshot["toId"] as! String
        self.text = snapshot["text"] as! String
        self.timestamp = snapshot["timestamp"] as! NSNumber!
    }
    
    // nếu fromId == idSender -> id người nhận
    // fromId != idSender -> id sender
    func chatPartnerId(currentUserId:String) -> String? {
        return fromId == currentUserId ? toId : fromId
    }
}
