//
//  MenuBarCollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: BaseCollectionViewCell {
    
    let imgMenuView:UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
//    override var isSelected: Bool{
//        didSet{
//            if isSelected == true {
//                self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            }else{
//                self.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//            }
//        }
//    }
    
    override func setupView() {
        self.addSubview(imgMenuView)
        
        self.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imgMenuView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imgMenuView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgMenuView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5, constant: 0).isActive = true
        imgMenuView.widthAnchor.constraint(equalTo: imgMenuView.heightAnchor, multiplier: 1, constant: 0).isActive = true
    }
    
    
}
