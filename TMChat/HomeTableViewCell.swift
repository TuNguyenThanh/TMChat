//
//  HomeTableViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit



class HomeTableViewCell: BaseTableViewCell {
    
    let lblName:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblText:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgAvatar:UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 30
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblTimestamp:UILabel = {
        let lbl = UILabel()
        lbl.text = "HH:MM:SS"
        lbl.textColor = UIColor.darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func setupView(){
        self.backgroundColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.addSubview(imgAvatar)
        self.addSubview(lblName)
        self.addSubview(lblText)
        self.addSubview(lblTimestamp)
        
        imgAvatar.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -20).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
        imgAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imgAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        lblName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lblName.leftAnchor.constraint(equalTo: imgAvatar.rightAnchor, constant: 10).isActive = true
        lblName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lblText.topAnchor.constraint(equalTo: lblName.bottomAnchor).isActive = true
        lblText.leftAnchor.constraint(equalTo: lblName.leftAnchor).isActive = true
        lblText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        lblText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lblTimestamp.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lblTimestamp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        lblTimestamp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lblTimestamp.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
