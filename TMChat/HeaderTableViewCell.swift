//
//  HeaderTableViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit


class HeaderTableViewCell: BaseTableViewCell {
    let picker = UIImagePickerController()
    
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
        print("fefwefe")
        let alertView:UIAlertController = UIAlertController(title: "Chon Hinh", message: "Vui long chon", preferredStyle: UIAlertControllerStyle.alert)
        let photoLibrary:UIAlertAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default) { (photoLibrary) in
            print("photo Lybrary")
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            UIApplication.shared.keyWindow?.rootViewController?.present(self.picker, animated: true, completion: nil)
        }
        let camera:UIAlertAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (camera) in
            print("Camera")
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerControllerSourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                UIApplication.shared.keyWindow?.rootViewController?.present(self.picker,animated: true,completion: nil)
            }else{
                //self.noCamera()
            }
        }
        alertView.addAction(photoLibrary)
        alertView.addAction(camera)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
    
    override func setupView(){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
        picker.delegate = self
        
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

extension HeaderTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgAvatar.image = chosenImage
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}









