//
//  HeaderTableViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

protocol HeaderTableViewCellDelegate: class {
    func didTapAvatar()
}

class HeaderTableViewCell: UITableViewCell {

    var delegate:HeaderTableViewCellDelegate?
    
    lazy var imgAvatar:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.layer.cornerRadius = 128 / 2
        img.clipsToBounds = true
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderTableViewCell.aChooseImage(tap:))))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Thanh Tu"
        lbl.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func aChooseImage(tap : UITapGestureRecognizer){
        if let delegate = self.delegate {
            delegate.didTapAvatar()
        }
    }
    
    func setupView(){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
        
        self.addSubview(imgAvatar)
        self.addSubview(lblName)

        imgAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imgAvatar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imgAvatar.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imgAvatar.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        lblName.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 10).isActive = true
        lblName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

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
