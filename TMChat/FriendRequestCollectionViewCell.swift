//
//  FriendRequestCollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 11/11/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class FriendRequestCollectionViewCell: BaseCollectionViewCell {
    lazy var imageAvatar:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(abtnRequest)))
        return img
    }()
    
    let viewOnOff:UIView = {
        let v = UIView()
        v.layer.cornerRadius = 5
        v.clipsToBounds = true
        v.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func abtnRequest(){
        print("tap")
        let appearance = SCLAlertView.SCLAppearance( showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Bỏ qua") {
            print("bo qua")
        }
        alert.addButton("Kết bạn") {
            print("ket ban")
        }
        
        alert.showNotice("Kết bạn", subTitle: "Yêu cầu kết bạn")
    }
    
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        self.addSubview(imageAvatar)
        self.addSubview(viewOnOff)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: imageAvatar)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: imageAvatar)
        
        self.viewOnOff.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.viewOnOff.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.viewOnOff.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.viewOnOff.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
    }
    
}
