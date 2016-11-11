//
//  Page4CollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol Page4CollectionViewCellDelegate {
    func presentLoginVC()
}

protocol Page4CollectionViewCellDelegate2 {
    func showPicker(picker:UIImagePickerController)
    func dissmissVC()
}

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
    
    var delegate:Page4CollectionViewCellDelegate?
    var delegate2:Page4CollectionViewCellDelegate2?
    override func setupView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(tableView)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: tableView)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: tableView)
        
    }
}

extension Page4CollectionViewCell: HeaderTableViewCellDelegate{
    func showPickerImageView(picker: UIImagePickerController) {
        self.delegate2?.showPicker(picker: picker)
    }

    func dissmissVC() {
        self.delegate2?.dissmissVC()
    }
}

extension Page4CollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellHeader", for: indexPath) as! HeaderTableViewCell
            cell.delegate = self
            cell.lblName.text = userCurrent?.userName
            print(userCurrent?.avatarURL ?? "avatarUrl")
            if userCurrent?.avatarURL != nil {
                cell.imgAvatar.loadImage(urlString: (userCurrent?.avatarURL)!)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath) as! DetailTableViewCell
            if indexPath.row == 1 {
                cell.imgIcon.image = UIImage(named: "email")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = userCurrent?.email!
            }else if indexPath.row == 2 {
                cell.imgIcon.image = UIImage(named: "phone")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = userCurrent?.phone!
            }else if indexPath.row == 3 {
                cell.imgIcon.image = UIImage(named: "resetpass")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "Đặt lại mật khẩu"
            }else if indexPath.row == 4 {
                cell.imgIcon.image = UIImage(named: "logout")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                cell.lbl.text = "Đăng xuất"
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        }else if indexPath.row == 1 {
            print("email")
        }else if indexPath.row == 2 {
            let appearance = SCLAlertView.SCLAppearance(showCloseButton: true)
            let alert = SCLAlertView(appearance: appearance)
            let txt = alert.addTextField("Nhập số điện thoại...")
            _ = alert.addButton("Thay đổi") {
                Helper.helper.updateNumberPhone(numberPhone: txt.text!)
                let cell = tableView.cellForRow(at: indexPath) as! DetailTableViewCell
                cell.lbl.text = txt.text
            }
            _ = alert.showEdit("Thay đổi số điện thoại", subTitle:"Vui lòng nhập số điện thoại",closeButtonTitle: "Huỷ")
        }else if indexPath.row == 3 {
            //Reset password
            Helper.helper.resetPasswordToEmail()
        }else if indexPath.row == 4 {
            //Logout
            Helper.helper.logout(completion: { (check) in
                if check == true {
                    self.delegate?.presentLoginVC()
                }
            })
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











