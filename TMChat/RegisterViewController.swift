//
//  RegisterViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/9/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    lazy var imgChooseAvatar:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.layer.cornerRadius = 128 / 2
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        img.clipsToBounds = true
        img.image = UIImage(named: "camera")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatLogViewController.aChooseImage(tap:))))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let imgUsername:UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.image = UIImage(named: "friend")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let txtUsername:UITextField = {
        let txt = UITextField()
        txt.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txt.attributedPlaceholder = NSAttributedString(string:"Username", attributes:[NSForegroundColorAttributeName: UIColor.white])
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    let viewLineUsername:UIView = {
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
        btn.backgroundColor = UIColor.clear
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
        btn.backgroundColor = UIColor.clear
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
        self.view.addSubview(imgChooseAvatar)
        self.view.addSubview(txtUsername)
        self.view.addSubview(imgUsername)
        self.view.addSubview(viewLineUsername)
        self.view.addSubview(txtEmail)
        self.view.addSubview(imgEmail)
        self.view.addSubview(viewLineEmail)
        self.view.addSubview(txtPassword)
        self.view.addSubview(viewLinePassword)
        self.view.addSubview(imgPassword)
        self.view.addSubview(btnRegister)
        self.view.addSubview(btnCancel)
        
        txtUsername.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        picker.delegate = self
        
        imgChooseAvatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imgChooseAvatar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        imgChooseAvatar.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imgChooseAvatar.widthAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.txtUsername.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.txtUsername.topAnchor.constraint(equalTo: self.imgChooseAvatar.bottomAnchor, constant: 40).isActive = true
        self.txtUsername.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 112).isActive = true
        self.txtUsername.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.imgUsername.rightAnchor.constraint(equalTo: self.txtUsername.leftAnchor, constant: -8).isActive = true
        self.imgUsername.bottomAnchor.constraint(equalTo: self.txtUsername.bottomAnchor, constant: -8).isActive = true
        self.imgUsername.heightAnchor.constraint(equalTo: self.txtUsername.heightAnchor, constant: -8).isActive = true
        self.imgUsername.widthAnchor.constraint(equalTo: self.imgUsername.heightAnchor).isActive = true
        
        self.viewLineUsername.heightAnchor.constraint(equalToConstant: 2).isActive = true
        self.viewLineUsername.leftAnchor.constraint(equalTo: self.imgUsername.leftAnchor).isActive = true
        self.viewLineUsername.topAnchor.constraint(equalTo: self.txtUsername.bottomAnchor, constant: 0).isActive = true
        self.viewLineUsername.rightAnchor.constraint(equalTo: self.txtUsername.rightAnchor).isActive = true

        self.txtEmail.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.txtEmail.topAnchor.constraint(equalTo: self.viewLineUsername.bottomAnchor, constant: 20).isActive = true
        self.txtEmail.leftAnchor.constraint(equalTo: self.txtUsername.leftAnchor).isActive = true
        self.txtEmail.heightAnchor.constraint(equalTo: txtUsername.heightAnchor).isActive = true
        
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
    }
    
    func abtnCancel(){
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    func abtnRegister(){
        print("Register")
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",style:.default,handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }
    
    func aChooseImage(tap : UITapGestureRecognizer){
        print("abc")
        
        let alertView:UIAlertController = UIAlertController(title: "Chon Hinh", message: "Vui long chon", preferredStyle: UIAlertControllerStyle.alert)
        let photoLibrary:UIAlertAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default) { (photoLibrary) in
            print("photo Lybrary")
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }
        let camera:UIAlertAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (camera) in
            print("Camera")
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerControllerSourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            }else{
                self.noCamera()
            }
        }
        alertView.addAction(photoLibrary)
        alertView.addAction(camera)
        
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineUsername.backgroundColor = UIColor.lightGray
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
        if textField == txtUsername {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineUsername.backgroundColor = UIColor.white
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgChooseAvatar.image = chosenImage
        self.dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}









