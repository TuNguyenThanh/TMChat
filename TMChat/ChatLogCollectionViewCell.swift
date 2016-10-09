//
//  ChatLogCollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/9/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class ChatLogCollectionViewCell: BaseCollectionViewCell {
    
    let txtTextMessages:UITextView = {
        let txt = UITextView()
        txt.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.backgroundColor = UIColor.clear
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let bubbleView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        v.layer.cornerRadius = 16
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgAvatar:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 16
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    var bubbleViewWithAnchor:NSLayoutConstraint?
    var bubbleViewRightAnchor:NSLayoutConstraint?
    var bubbleViewLeftAnchor:NSLayoutConstraint?
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(bubbleView)
        self.addSubview(imgAvatar)
        bubbleView.addSubview(txtTextMessages)
    
        imgAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        imgAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imgAvatar.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imgAvatar.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        ///--
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: imgAvatar.rightAnchor, constant: 8)
        bubbleViewLeftAnchor?.isActive = false
        
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        bubbleViewWithAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleViewWithAnchor?.isActive = true
        
        
        ///----
        txtTextMessages.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        txtTextMessages.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        txtTextMessages.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -8).isActive = true
        txtTextMessages.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true

    }

}








