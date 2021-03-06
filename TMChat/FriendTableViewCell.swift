//
//  FriendTableViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

protocol FriendTableViewCellDelegate {
    func sendFriend(uid:String)
    func cancelFriendRequest(uid:String)
}

class FriendTableViewCell: BaseTableViewCell {
    
    let lblName:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    let lblOnOff:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let viewOnOff:UIView = {
        let v = UIView()
        v.layer.cornerRadius = 5
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var btnSendRequest:UIButton = {//sendRequest
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.clear
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.setTitle("Kết bạn", for: UIControlState.normal)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(FriendTableViewCell.abtnSendFriend), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func abtnSendFriend(){
        print("touched")
        if btnSendRequest.currentTitle == "Kết bạn" {
            self.delegate?.sendFriend(uid: uid!)
            btnSendRequest.setTitle("Huỷ", for: UIControlState.normal)
        }else{
            self.delegate?.cancelFriendRequest(uid: uid!)
            btnSendRequest.setTitle("Kết bạn", for: UIControlState.normal)
        }
    }
    
    var delegate:FriendTableViewCellDelegate?
    var uid:String?
    
    override func setupView() {
        self.selectionStyle = .none
        self.addSubview(imgAvatar)
        self.addSubview(lblName)
        self.addSubview(lblOnOff)
        self.addSubview(viewOnOff)
        self.addSubview(btnSendRequest)
        
        imgAvatar.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -20).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
        imgAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imgAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        lblName.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        lblName.leftAnchor.constraint(equalTo: imgAvatar.rightAnchor, constant: 10).isActive = true
        lblName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lblOnOff.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblOnOff.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        viewOnOff.widthAnchor.constraint(equalToConstant: 10).isActive = true
        viewOnOff.heightAnchor.constraint(equalTo: viewOnOff.widthAnchor).isActive = true
        viewOnOff.centerYAnchor.constraint(equalTo: lblOnOff.centerYAnchor).isActive = true
        viewOnOff.rightAnchor.constraint(equalTo: lblOnOff.leftAnchor, constant: -8).isActive = true
        
        btnSendRequest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnSendRequest.rightAnchor.constraint(equalTo: viewOnOff.leftAnchor, constant: -10).isActive = true
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
