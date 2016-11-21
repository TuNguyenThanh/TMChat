//
//  HeaderTableViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

protocol HeaderTableViewCellDelegate {
    func showPickerImageView(picker:UIImagePickerController)
    func dissmissVC()
}

class HeaderTableViewCell: BaseTableViewCell {
    var delegate:HeaderTableViewCellDelegate?
   
    lazy var imgAvatar:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.layer.cornerRadius = 128 / 2
        img.layer.borderColor = UIColor.black.cgColor
        img.clipsToBounds = true
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderTableViewCell.selectImage)))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var lblName:UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        lbl.font = UIFont(name: "HelveticaNeue", size: 23)
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        lbl.clipsToBounds = true
        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HeaderTableViewCell.abtnEditUserName(tap:))))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
   
    func abtnEditUserName(tap : UITapGestureRecognizer){
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: true)
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Nhập tên...")
        _ = alert.addButton("Thay đổi") {
           self.lblName.text = txt.text
            Helper.helper.updateName(name: txt.text!)
        }
        _ = alert.showEdit("Thay đổi tên", subTitle:"Bạn có muốn thay đổi tên hay không?", closeButtonTitle: "Huỷ")
    }
    
    override func setupView(){
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
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension HeaderTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func selectImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        imagePicker.navigationBar.tintColor = .white
        imagePicker.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        let alert = SCLAlertView()
        alert.addButton("Photo Library") {
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
            imagePicker.modalPresentationStyle = .popover
           
            self.delegate?.showPickerImageView(picker: imagePicker)
        }
        alert.addButton("Camera") {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.modalPresentationStyle = .fullScreen
                
                self.delegate?.showPickerImageView(picker: imagePicker)
            } else {
                //self.noCamera()
            }
        }
        alert.showNotice("Chọn hình", subTitle: "Chọn 1 trong 2",closeButtonTitle: "Thoát")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            imgAvatar.image = selectedImage
            let appearance = SCLAlertView.SCLAppearance(showCloseButton: true)
            let alert = SCLAlertView(appearance: appearance)
            _ = alert.addButton("Thay đổi") {
                Helper.helper.updateAvatarImage(imgAvatar: self.imgAvatar)
            }
            _ = alert.showInfo("Thay đổi ảnh đại diện", subTitle:"Bạn có muốn thay đổi hay không?", closeButtonTitle: "Huỷ")
        }
        self.delegate?.dissmissVC()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.dissmissVC()
    }
}









