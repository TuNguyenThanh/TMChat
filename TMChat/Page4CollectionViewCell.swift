//
//  Page4CollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class Page4CollectionViewCell: BaseCollectionViewCell {
    
    
    lazy var tableView:UITableView = {
        let tbl = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tbl.dataSource = self
        tbl.delegate = self
        tbl.separatorColor = UIColor.clear
        tbl.separatorStyle = .none
        tbl.register(HeaderTableViewCell.self, forCellReuseIdentifier: "CellHeader")
        tbl.register(DetailTableViewCell.self, forCellReuseIdentifier: "CellDetail")
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    override func setupView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.addSubview(tableView)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: tableView)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: tableView)
    
    }
}

extension Page4CollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellHeader", for: indexPath) as! HeaderTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath) as! DetailTableViewCell
            
            if indexPath.row == 1 {
                cell.imgIcon.image = UIImage(named: "email")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "thanhtu0903016975@gmail.com"
            }else if indexPath.row == 2 {
                cell.imgIcon.image = UIImage(named: "phone")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "0903016975"
            }else if indexPath.row == 3 {
                cell.imgIcon.image = UIImage(named: "logout")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "cap nhat thong tin"
            }else if indexPath.row == 4 {
                cell.imgIcon.image = UIImage(named: "logout")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "Quen mat khhau"
            }else if indexPath.row == 5 {
                cell.imgIcon.image = UIImage(named: "logout")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "Logout"
            }
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        }else if indexPath.row == 1{
            print("email")
        }else if indexPath.row == 2{
            print("phone")
        }else if indexPath.row == 3{
            print("logout")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        }else{
            return 50.0
        }
    }
}










