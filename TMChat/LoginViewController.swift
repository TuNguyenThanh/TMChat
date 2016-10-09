//
//  Login2ViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/9/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController  {

    
    let logo:UILabel = {
        let lbl = UILabel()
        lbl.text = "TM Chat"
        lbl.font = UIFont.boldSystemFont(ofSize: 48)
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
    
    lazy var btnLogin:UIButton = {
        let btn = UIButton(type: .system )
        btn.setTitle("Login", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor.clear
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(LoginViewController.abtnLogin), for: UIControlEvents.touchUpInside)
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
        btn.addTarget(self, action: #selector(LoginViewController.abtnRegister), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnLoginWithFB:UIButton = {
        let btn = UIButton(type: .system )
        btn.setTitle("Login with Facebook", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor.clear
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    func setuppView(){
        self.view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.view.addSubview(logo)
        self.view.addSubview(txtEmail)
        self.view.addSubview(imgEmail)
        self.view.addSubview(viewLineEmail)
        self.view.addSubview(txtPassword)
        self.view.addSubview(viewLinePassword)
        self.view.addSubview(imgPassword)
        self.view.addSubview(btnLogin)
        self.view.addSubview(btnRegister)
        self.view.addSubview(btnLoginWithFB)
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
      
        self.txtEmail.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.txtEmail.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 100).isActive = true
        self.txtEmail.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 112).isActive = true
        self.txtEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true

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
        
        self.btnLogin.topAnchor.constraint(equalTo: self.imgPassword.bottomAnchor, constant: 40).isActive = true
        self.btnLogin.leftAnchor.constraint(equalTo: self.imgPassword.leftAnchor).isActive = true
        self.btnLogin.widthAnchor.constraint(equalTo: self.txtPassword.widthAnchor, multiplier: 1/2).isActive = true
        self.btnLogin.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.btnRegister.topAnchor.constraint(equalTo: self.btnLogin.topAnchor).isActive = true
        self.btnRegister.rightAnchor.constraint(equalTo: self.txtPassword.rightAnchor, constant: -8).isActive = true
        self.btnRegister.widthAnchor.constraint(equalTo: self.txtPassword.widthAnchor, multiplier: 1/2).isActive = true
        self.btnRegister.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.btnLoginWithFB.topAnchor.constraint(equalTo: self.btnRegister.bottomAnchor, constant: 20).isActive = true
        self.btnLoginWithFB.rightAnchor.constraint(equalTo: self.txtPassword.rightAnchor, constant: -8).isActive = true
        self.btnLoginWithFB.leftAnchor.constraint(equalTo: self.imgPassword.leftAnchor).isActive = true
        self.btnLoginWithFB.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    
    func abtnLogin(){
        print("Login")
        let mainVC = MainViewController()
        self.present( UINavigationController(rootViewController: mainVC), animated: true, completion: nil)
    }
    
    func abtnRegister(){
        print("Register")
        let registerVC = RegisterViewController()
        self.present(registerVC, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setuppView()
    }

    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineEmail.backgroundColor = UIColor.lightGray
            })
        } else if textField == txtPassword {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLinePassword.backgroundColor = UIColor.lightGray
            })
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLineEmail.backgroundColor = UIColor.white
            })
        } else if textField == txtPassword {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewLinePassword.backgroundColor = UIColor.white
            })
        }
        return true
    }
 
}





