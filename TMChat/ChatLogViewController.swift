//
//  ABCViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class ChatLogViewController: UIViewController {
    let cellId:String = "Cell"
    var arrMessages:Array<Messages> = Array<Messages>()
    
    lazy var myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        coll.dataSource = self
        coll.delegate = self
        coll.register(ChatLogCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    
    let inputComponents:UIView = {
        let vi = UIView()
        vi.translatesAutoresizingMaskIntoConstraints = false
        return vi
    }()
    
    lazy var btnSend:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Send", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(abtnSend), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var inputTextField:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter messages..."
        txt.delegate = self
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    lazy var imgChooseImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "upload_image")
        img.isUserInteractionEnabled = true
        img.clipsToBounds = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatLogViewController.selectImage)))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let viewLine:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        vi.translatesAutoresizingMaskIntoConstraints = false
        return vi
    }()
    
    func abtnDismiss(){
        print("dismiss view")
        self.dismiss(animated: true, completion: nil)
    }

    func setupView(){
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.view.addSubview(myCollectionView)
        self.view.addSubview(inputComponents)
        inputComponents.addSubview(btnSend)
        inputComponents.addSubview(imgChooseImage)
        inputComponents.addSubview(inputTextField)
        inputComponents.addSubview(viewLine)
        
        myCollectionView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        myCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        myCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        inputComponents.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        inputComponents.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inputComponents.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        inputComponents.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        imgChooseImage.leftAnchor.constraint(equalTo: inputComponents.leftAnchor).isActive = true
        imgChooseImage.topAnchor.constraint(equalTo: inputComponents.topAnchor).isActive = true
        imgChooseImage.bottomAnchor.constraint(equalTo: inputComponents.bottomAnchor).isActive = true
        imgChooseImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        btnSend.rightAnchor.constraint(equalTo: inputComponents.rightAnchor).isActive = true
        btnSend.centerYAnchor.constraint(equalTo: inputComponents.centerYAnchor).isActive = true
        btnSend.heightAnchor.constraint(equalTo: inputComponents.heightAnchor).isActive = true
        btnSend.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        inputTextField.topAnchor.constraint(equalTo: inputComponents.topAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: btnSend.leftAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: inputComponents.bottomAnchor).isActive = true
        inputTextField.leftAnchor.constraint(equalTo: imgChooseImage.rightAnchor, constant: 0).isActive = true
        
        viewLine.leftAnchor.constraint(equalTo: inputComponents.leftAnchor).isActive = true
        viewLine.topAnchor.constraint(equalTo: inputComponents.topAnchor, constant: -1).isActive = true
        viewLine.rightAnchor.constraint(equalTo: inputComponents.rightAnchor).isActive = true
        viewLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func observeMessages(){
        Helper.helper.fetchUserMessages { (mess) in
            //print(mess)
            if mess.toId == userCurrent?.uid && mess.fromId == self.userTo?.uid || mess.toId == self.userTo?.uid && mess.fromId == userCurrent?.uid{
                
                self.arrMessages.append(mess)
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
    
    func abtnSend(){
        print(inputTextField.text!)
        Helper.helper.sendMessage(text: inputTextField.text!,toId: (userTo?.uid)!, fromId: (userCurrent?.uid)!)
        inputTextField.text = nil
    }

    var userTo:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        observeMessages()
        print((userTo?.uid)! as String)
        print((userCurrent?.uid)! as String)
        print(self.arrMessages)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.myCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ChatLogViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ChatLogCollectionViewCell
        
        let messages = self.arrMessages[indexPath.row]
        cell.txtTextMessages.text = messages.text
        if messages.fromId == userCurrent?.uid {
            //outgoing bubble
            cell.bubbleView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            cell.bubbleViewRight?.isActive = true
            cell.bubbleViewLeft?.isActive = false
            cell.imgAvatar.isHidden = true
        }else {
            //incoming bubble
            cell.bubbleView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.bubbleViewRight?.isActive = false
            cell.bubbleViewLeft?.isActive = true
            cell.imgAvatar.isHidden = false
        }

        cell.bubbleViewWith?.constant = estimateFrameForText(text: messages.text).width + 32
        return cell
    }
}

extension ChatLogViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 80
        if let isText = self.arrMessages[indexPath.row].text {
            height = estimateFrameForText(text: isText).height + 20
        }
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    //get with height text chat bubble
    func estimateFrameForText(text:String) -> CGRect{
        let size = CGSize(width: 200, height: 999)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)], context: nil)
    }
}

extension ChatLogViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.abtnSend()
        return true
    }
}

extension ChatLogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func selectImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) 
        imagePicker.navigationBar.tintColor = .white
        imagePicker.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white ]
        
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
//        var selectedImageFromPicker: UIImage?
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            selectedImageFromPicker = editedImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            selectedImageFromPicker = originalImage
//        }
//        
//        if let selectedImage = selectedImageFromPicker {
//            imgChooseAvatar.image = selectedImage
//        }
        self.dismiss(animated:true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}







