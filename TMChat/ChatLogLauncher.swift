//
//  ChatLogLauncher.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class ChatLogLauncher: NSObject {
    func showChatLogView(){
        print("chat log view show")
        if let keyWindown = UIApplication.shared.keyWindow {
            //setting chatlogcontroller
            let chatLogVC = ChatLogViewController(frame: CGRect(x: keyWindown.frame.width - 10, y: keyWindown.frame.height - 10, width: 10, height: 10))
            
            keyWindown.addSubview(chatLogVC)
            
            //Animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                chatLogVC.frame =  CGRect(x: 0, y: 0, width: keyWindown.frame.width, height: keyWindown.frame.height)
                }, completion: { (true) in
                    //maybe we'll do something here later...
                    //UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
