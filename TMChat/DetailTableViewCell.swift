//
//  DetailTableViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    let imgIcon:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
        self.addSubview(imgIcon)
        self.addSubview(lbl)
        
        
        imgIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        imgIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgIcon.heightAnchor.constraint(equalTo: imgIcon.widthAnchor).isActive = true
        
        lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lbl.leftAnchor.constraint(equalTo: imgIcon.rightAnchor, constant: 8).isActive = true
        lbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        lbl.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
