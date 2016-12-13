//
//  FriendRequestCollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 11/11/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

protocol FriendRequestCollectionViewCellDelegate {
    func  sendFriendRequest(uid:String, indexPath:Int)
}

class FriendRequestCollectionViewCell: BaseCollectionViewCell {
    lazy var imgAvatar:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aimgSendRequest)))
        return img
    }()
    
    let viewOnOff:UIView = {
        let v = UIView()
        v.layer.cornerRadius = 5
        v.clipsToBounds = true
        v.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func aimgSendRequest(){
        print("tap")
        self.delegate?.sendFriendRequest(uid: uid!,indexPath: indexPath!)
    }
    
    var delegate:FriendRequestCollectionViewCellDelegate?
    var uid:String?
    var indexPath:Int?
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.addSubview(imgAvatar)
        self.addSubview(viewOnOff)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: imgAvatar)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: imgAvatar)
        
        self.viewOnOff.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.viewOnOff.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.viewOnOff.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.viewOnOff.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
    }
    
}
