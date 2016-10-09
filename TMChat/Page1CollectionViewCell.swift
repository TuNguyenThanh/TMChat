//
//  Page1CollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

var usernameSelected:String!

class Page1CollectionViewCell: BaseCollectionViewCell {
    
    let cellId:String = "Cell"
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(myTableView)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: myTableView)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: myTableView)
    }
    
    
    lazy var myTableView:UITableView = {
        let tbl = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(HomeTableViewCell.self, forCellReuseIdentifier: self.cellId)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
}

extension Page1CollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! HomeTableViewCell
        
        cell.lblName.text = "Thanh Tu"
        cell.imgAvatar.image = UIImage(named: "avatar")
        cell.lblText.text = "Hello thanh tu"
        cell.lblTimestamp.text = "12:03 PM"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatLogVC = ChatLogLauncher()
        usernameSelected = "Nguyen Thanh Tu"
        chatLogVC.showChatLogView()
    }
}




