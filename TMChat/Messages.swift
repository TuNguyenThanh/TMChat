//
//  Message.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/12/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit
import Firebase
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
    
    init(key:String , snapshot: Dictionary<String,AnyObject>) {
        self.keyMess = key
        self.fromId = snapshot["fromId"] as! String
        self.toId = snapshot["toId"] as! String
        self.text = snapshot["text"] as! String
        self.timestamp = snapshot["timestamp"] as! NSNumber!
    }
    
    func chatPartnerId() -> String? {
        return fromId == FIRAuth.auth()?.currentUser?.uid ? toId : fromId
        //ban chat, neu = usercurrent thi tra ve id ban chat, nguoc lai
    }
}

//struct Messages {
//    let messageId:String!
//    let toId:String!
//    var timestamp: Date = Date()
//    let text:String!
//    let mediaType:String!
//    let fileURL:String!
//    
//    
//    init(key: String , snapshot: Dictionary<String,AnyObject>){
//        self.messageId = key
//        self.toId = snapshot["toId"] as! String
//        if let timeInterval1970 = snapshot["timestamp"] as? TimeInterval {
//            let date:Date = Date(timeIntervalSince1970: timeInterval1970)
//            self.timestamp = date
//        }
//        if let text = snapshot["text"] as? String {
//            self.text = text
//        }else{
//            self.text = ""
//        }
//        self.mediaType = snapshot["mediaType"] as! String
//        
//        if let file = snapshot["fileURL"] as? String{
//            self.fileURL = file
//        }else{
//            self.fileURL = ""
//        }
//    }
//    
//    
//}
