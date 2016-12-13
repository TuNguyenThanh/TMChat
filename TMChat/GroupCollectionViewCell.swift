//
//  GroupCollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/16/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: BaseCollectionViewCell {
    
    lazy var imgGroup:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblGroupName:UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.addSubview(imgGroup)
        self.addSubview(lblGroupName)
                
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: imgGroup)
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0(150)]", views: imgGroup)
        
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: lblGroupName)
        lblGroupName.topAnchor.constraint(equalTo: imgGroup.bottomAnchor).isActive = true
        lblGroupName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
