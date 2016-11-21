//
//  RegisterViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/9/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    let bg:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "bg")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var imgChooseAvatar:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.layer.cornerRadius = 128 / 2
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        img.clipsToBounds = true
        img.image = UIImage(named: "camera-1")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let imgName:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.image = UIImage(named: "friend")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let txtName:UITextField = {
        let txt = UITextField()
        txt.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txt.attributedPlaceholder = NSAttributedString(string:"Name", attributes:[NSForegroundColorAttributeName: UIColor.white])
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let viewLineName:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgEmail:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.image = UIImage(named: "email")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let txtEmail:UITextField = {
        let txt = UITextField()
        txt.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txt.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSForegroundColorAttributeName: UIColor.white])
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let viewLineEmail:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let imgPassword:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.image = UIImage(named: "key")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let txtPassword:UITextField = {
        let txt = UITextField()
        txt.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txt.isSecureTextEntry = true
        txt.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName: UIColor.white])
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let viewLinePassword:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var btnCancel:UIButton = {
        let btn = UIButton(type: .system )
        btn.setTitle("Cancel", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor(red: 212/255, green: 41/255, blue: 41/255, alpha: 0.5)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(RegisterViewController.abtnCancel), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var btnRegister:UIButton = {
        let btn = UIButton(type: .system )
        btn.setTitle("Register", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor(red: 212/255, green: 41/255, blue: 41/255, alpha: 0.5)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(RegisterViewController.abtnRegister), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func setupView(){
        self.view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.view.addSubview(bg)
        self.view.addSubview(imgChooseAvatar)
        self.view.addSubview(txtName)
        self.view.addSubview(imgName)
        self.view.addSubview(viewLineName)
        self.view.addSubview(txtEmail)
        self.view.addSubview(imgEmail)
        self.view.addSubview(viewLineEmail)
        self.view.addSubview(txtPassword)
        self.view.addSubview(viewLinePassword)
        self.view.addSubview(imgPassword)
        self.view.addSubview(btnRegister)
        self.view.addSubview(btnCancel)
        
        txtName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        self.view.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: bg)
        self.view.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: bg)
        
        imgChooseAvatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imgChooseAvatar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
        imgChooseAvatar.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imgChooseAvatar.widthAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.txtName.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.txtName.topAnchor.constraint(equalTo: self.imgChooseAvatar.bottomAnchor, constant: 40).isActive = true
        self.txtName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 112).isActive = true
        self.txtName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.imgName.rightAnchor.constraint(equalTo: self.txtName.leftAnchor, constant: -8).isActive = true
        self.imgName.bottomAnchor.constraint(equalTo: self.txtName.bottomAnchor, constant: -8).isActive = true
        self.imgName.heightAnchor.constraint(equalTo: self.txtName.heightAnchor, constant: -8).isActive = true
        self.imgName.widthAnchor.constraint(equalTo: self.imgName.heightAnchor).isActive = true
        
        self.viewLineName.heightAnchor.constraint(equalToConstant: 2).isActive = true
        self.viewLineName.leftAnchor.constraint(equalTo: self.imgName.leftAnchor).isActive = true
        self.viewLineName.topAnchor.constraint(equalTo: self.txtName.bottomAnchor, constant: 0).isActive = true
        self.viewLineName.rightAnchor.constraint(equalTo: self.txtName.rightAnchor).isActive = true

        self.txtEmail.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.txtEmail.topAnchor.constraint(equalTo: self.viewLineName.bottomAnchor, constant: 20).isActive = true
        self.txtEmail.leftAnchor.constraint(equalTo: self.txtName.leftAnchor).isActive = true
        self.txtEmail.heightAnchor.constraint(equalTo: txtName.heightAnchor).isActive = true
        
        self.imgEmail.rightAnchor.constraint(equalTo: self.txtEmail.leftAnchor, constant: -8).isActive = true
        self.imgEmail.bottomAnchor.constraint(equalTo: self.txtEmail.bottomAnchor, constant: -8).isActive = true
        self.imgEmail.heightAnchor.constraint(equalTo: self.txtEmail.heightAnchor, constant: -8).isActive = true
        self.imgEmail.widthAnchor.constraint(equalTo: self.imgEmail.heightAnchor).isActive = true
        
        self.viewLineEmail.heightAnchor.constraint(equalToConstant: 2).isActive = true
        self.viewLineEmail.leftAnchor.constraint(equalTo: self.imgEmail.leftAnchor).isActive = true
        self.viewLineEmail.topAnchor.constraint(equalTo: self.txtEmail.bottomAnchor, constant: 0).isActive = true
        self.viewLineEmail.rightAnchor.constraint(equalTo: self.txtEmail.rightAnchor).isActive = true

        self.txtPassword.rightAnchor.constraint(equalTo: self.txtEmail.rightAnchor).isActive = true
        self.txtPassword.topAnchor.constraint(equalTo: self.viewLineEmail.bottomAnchor, constant: 20).isActive = true
        self.txtPassword.leftAnchor.constraint(equalTo: self.txtEmail.leftAnchor).isActive = true
        self.txtPassword.heightAnchor.constraint(equalTo: self.txtEmail.heightAnchor).isActive = true
        
        self.viewLinePassword.heightAnchor.constraint(equalToConstant: 2).isActive = true
        self.viewLinePassword.leftAnchor.constraint(equalTo: self.viewLineEmail.leftAnchor).isActive = true
        self.viewLinePassword.topAnchor.constraint(equalTo: self.txtPassword.bottomAnchor, constant: 0).isActive = true
        self.viewLinePassword.rightAnchor.constraint(equalTo: self.txtPassword.rightAnchor).isActive = true
        
        self.imgPassword.rightAnchor.constraint(equalTo: self.txtPassword.leftAnchor, constant: -8).isActive = true
        self.imgPassword.bottomAnchor.constraint(equalTo: self.txtPassword.bottomAnchor, constant: -8).isActive = true
        self.imgPassword.heightAnchor.constraint(equalTo: self.txtPassword.heightAnchor, constant: -8).isActive = true
        self.imgPassword.widthAnchor.constraint(equalTo: self.imgPassword.heightAnchor).isActive = true
        
        self.btnRegister.topAnchor.constraint(equalTo: self.imgPassword.bottomAnchor, constant: 40).isActive = true
        self.btnRegister.leftAnchor.constraint(equalTo: self.imgPassword.leftAnchor).isActive = true
        self.btnRegister.widthAnchor.constraint(equalTo: self.txtPassword.widthAnchor, multiplier: 1/2).isActive = true
        self.btnRegister.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.btnCancel.topAnchor.constraint(equalTo: self.btnRegister.topAnchor).isActive = true
        self.btnCancel.rightAnchor.constraint(equalTo: self.txtPassword.rightAnchor, constant: -8).isActive = true
        self.btnCancel.widthAnchor.constraint(equalTo: self.txtPassword.widthAnchor, multiplier: 1/2).isActive = true
        self.btnCancel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKey)))
    }
    
    ///hide key touch self
    func dismissKey(tap : UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    
    func abtnCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func abtnRegister(){
        if Helper.helper.checkInputRegister(name: txtName.text!, email: txtEmail.text!, pass: txtPassword.text!) == true {
            Helper.helper.registerUser(name: txtName.text!, email: txtEmail.text!, password: txtPassword.text!, imgAvatar: imgChooseAvatar) { (check) in
                if check == true {
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("dang ky that bai")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineName.backgroundColor = UIColor.lightGray
            })
        } else if textField == txtEmail {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineEmail.backgroundColor = UIColor.lightGray
            })
        }else if textField == txtPassword {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLinePassword.backgroundColor = UIColor.lightGray
            })
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtName {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineName.backgroundColor = UIColor.white
            })
        } else if textField == txtEmail {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineEmail.backgroundColor = UIColor.white
            })
        }else if textField == txtPassword {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLinePassword.backgroundColor = UIColor.white
            })
        }
        return true
    }
    
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func selectImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) // Background color
        imagePicker.navigationBar.tintColor = .white // Cancel button ~ any UITabBarButton items
        imagePicker.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        let alert = SCLAlertView()
        alert.addButton("Photo Library") {
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
            imagePicker.modalPresentationStyle = .popover
            self.present(imagePicker, animated: true, completion: nil)
        }
        alert.addButton("Camera") {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.modalPresentationStyle = .fullScreen
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                self.noCamera()
            }
        }
        alert.showNotice("Chọn hình", subTitle: "Chọn 1 trong 2",closeButtonTitle: "Thoát")
    }
    
    func noCamera(){
        let alter:UIAlertController = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: UIAlertControllerStyle.alert)
        let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alter.addAction(OK)
        self.present(alter, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            imgChooseAvatar.image = selectedImage
        }

        self.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}









