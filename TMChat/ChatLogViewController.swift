//
//  ABCViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/14/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

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

    var collectionViewBottomAnchor:NSLayoutConstraint?
    var bottomConstraint:CGFloat!
    func setupView(){
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(myCollectionView)
        
        myCollectionView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        
        collectionViewBottomAnchor = myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        collectionViewBottomAnchor?.isActive = true
        bottomConstraint = collectionViewBottomAnchor?.constant
        
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        myCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        myCollectionView.keyboardDismissMode = .interactive
        myCollectionView.alwaysBounceVertical = true
        
    }
    
    func observeMessages(){
        Helper.helper.fetchUserMessages { (mess) in
            //print(mess)
            if mess.toId == userCurrent?.uid && mess.fromId == self.userTo?.uid || mess.toId == self.userTo?.uid && mess.fromId == userCurrent?.uid{                
                self.arrMessages.append(mess)
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                    let indexPath = IndexPath(item: self.arrMessages.count - 1, section: 0)
                    self.myCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
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
        setupKeyboard()

        observeMessages()
        print((userTo?.uid)! as String)
        print((userCurrent?.uid)! as String)
        print(self.arrMessages)
    }
    
    lazy var inputContainerView:UIView = {
        let inputComponent = UIView()
        inputComponent.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        inputComponent.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        inputComponent.addSubview(self.btnSend)
        inputComponent.addSubview(self.imgChooseImage)
        inputComponent.addSubview(self.inputTextField)
        inputComponent.addSubview(self.viewLine)

        self.imgChooseImage.leftAnchor.constraint(equalTo: inputComponent.leftAnchor).isActive = true
        self.imgChooseImage.topAnchor.constraint(equalTo: inputComponent.topAnchor).isActive = true
        self.imgChooseImage.bottomAnchor.constraint(equalTo: inputComponent.bottomAnchor).isActive = true
        self.imgChooseImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.btnSend.rightAnchor.constraint(equalTo: inputComponent.rightAnchor).isActive = true
        self.btnSend.centerYAnchor.constraint(equalTo: inputComponent.centerYAnchor).isActive = true
        self.btnSend.heightAnchor.constraint(equalTo: inputComponent.heightAnchor).isActive = true
        self.btnSend.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.inputTextField.topAnchor.constraint(equalTo: inputComponent.topAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: self.btnSend.leftAnchor).isActive = true
        self.inputTextField.bottomAnchor.constraint(equalTo: inputComponent.bottomAnchor).isActive = true
        self.inputTextField.leftAnchor.constraint(equalTo: self.imgChooseImage.rightAnchor, constant: 0).isActive = true
        
        self.viewLine.leftAnchor.constraint(equalTo: inputComponent.leftAnchor).isActive = true
        self.viewLine.topAnchor.constraint(equalTo: inputComponent.topAnchor, constant: -1).isActive = true
        self.viewLine.rightAnchor.constraint(equalTo: inputComponent.rightAnchor).isActive = true
        self.viewLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return inputComponent
    }()
    
    override var inputAccessoryView: UIView?{
        get{
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupKeyboard(){
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil   )
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil   )
         //NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil   )
    }
    
//    func handleKeyboardDidShow() {
//        if self.arrMessages.count > 0 {
//            let indexPath = IndexPath(item: self.arrMessages.count - 1, section: 0)
//            self.myCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.top, animated: true)
//        }
//    }
    
    func keyboardWillShow(notification:Notification){
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        UIView.animate(withDuration: keyboardDuration!) {
            self.collectionViewBottomAnchor?.constant = -(keyboardFrame?.height)!
            self.view.layoutIfNeeded()
            if self.arrMessages.count > 0 {
                let indexPath = IndexPath(item: self.arrMessages.count - 1, section: 0)
                self.myCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.top, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification:Notification){
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        UIView.animate(withDuration: keyboardDuration!) {
            self.collectionViewBottomAnchor?.constant = self.bottomConstraint
            self.view.layoutIfNeeded()
            if self.arrMessages.count > 0 {
                let indexPath = IndexPath(item: self.arrMessages.count - 1, section: 0)
                self.myCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.top, animated: true)
            }
        }
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    var startFrame:CGRect?
    var backgroundView:UIView!
    func performZoomImage(image:UIImageView){
        self.startFrame = image.superview?.convert(image.frame, to: nil)
        //print(startFrame)
        
        let zoomingImage = UIImageView(frame: startFrame!)
        zoomingImage.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        zoomingImage.image = image.image
        zoomingImage.isUserInteractionEnabled = true
        zoomingImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageZoomOut)))
        
        if let keyWindown = UIApplication.shared.keyWindow{
            self.backgroundView = UIView(frame: keyWindown.frame)
            self.backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.backgroundView.alpha = 0
            
            keyWindown.addSubview(self.backgroundView)
            keyWindown.addSubview(zoomingImage)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.backgroundView.alpha = 1
                self.inputContainerView.alpha = 0
                
                // math?
                // h2 / w1 = h1 / w1
                // h2 = h1 / w1 * w1
                
                let height = (self.startFrame?.height)! / (self.startFrame?.width)! * keyWindown.frame.width
                zoomingImage.frame = CGRect(x: 0, y: 0, width: keyWindown.frame.size.width , height: height)
                zoomingImage.center = keyWindown.center
            }, completion: nil )
        }
    }
    
    func imageZoomOut(tap:UITapGestureRecognizer){
        if let zoomOut = tap.view {
            zoomOut.layer.cornerRadius = 16
            zoomOut.clipsToBounds = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                zoomOut.frame = self.startFrame!
                self.backgroundView.alpha = 0
                self.inputContainerView.alpha = 1
            }, completion: { (true) in
                zoomOut.removeFromSuperview()
            })
        }
    }
}

extension ChatLogViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ChatLogCollectionViewCell
        
        let messages = self.arrMessages[indexPath.row]
        cell.urlVideo = messages.urlVideo
        cell.txtTextMessages.text = messages.text
        cell.chatlogViewController = self
        
        cell.imgAvatar.loadImage(urlString: (userTo?.avatarURL)!)
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
        
        if let messageImageUrl = messages.urlImage {
            cell.messImage.loadImage(urlString: messageImageUrl)
            cell.messImage.isHidden = false
            cell.bubbleView.backgroundColor = UIColor.clear
        } else {
            cell.messImage.isHidden = true
        }
        
        if let text = messages.text {
            cell.bubbleViewWith?.constant = estimateFrameForText(text: text).width + 32
            cell.txtTextMessages.isHidden = false
        }else if (messages.urlImage) != nil {
            cell.bubbleViewWith?.constant = 200
            cell.txtTextMessages.isHidden = true
        }
        
        if let seconds = messages.timestamp?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            let dateFormater = DateFormatter()
            
            //get day mess
            let dfDay = DateFormatter()
            dfDay.dateFormat = "d"
            let day:Int = Int( dfDay.string(from: timestampDate))!
            
            //get day now
            let dayNow:Int = Int( dfDay.string(from: Date()))!
            
            if dayNow > day {
                dateFormater.dateFormat = "E, hh:mm a"
            }else{
                dateFormater.dateFormat = "hh:mm a"
            }
            
            cell.lblTimestamp.text = dateFormater.string(from: timestampDate)
        }
        
        if messages.urlVideo != nil {
            cell.btnPlay.isHidden = false
        }else{
            cell.btnPlay.isHidden = true
        }
               
        return cell
    }
}

extension ChatLogViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 80
        
        let mess = self.arrMessages[indexPath.item]
        if let isText = mess.text {
            height = estimateFrameForText(text: isText).height + 20
        }else if let imageWidth = mess.imageWidth?.floatValue, let imageHeight = mess.imageHeight?.floatValue  {
            // h1 / w1 = h2 / w2
            // solve for h1
            // h1 = h2 / w2 * w1
            
            height = CGFloat(imageHeight / imageWidth * 200)
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: height)
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
        self.inputContainerView.alpha = 0
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        imagePicker.allowsEditing = true
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) 
        imagePicker.navigationBar.tintColor = .white
        imagePicker.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white ]
        
        let appearance = SCLAlertView.SCLAppearance( showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
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
        alert.addButton("Thoát") {
             self.inputContainerView.alpha = 1
        }
        
        alert.showNotice("Chọn hình", subTitle: "Chọn 1 trong 2")
    }
    
    func noCamera(){
        let alter:UIAlertController = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: UIAlertControllerStyle.alert)
        let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alter.addAction(OK)
        self.present(alter, animated: true, completion: nil)
    }
    
    
    private func thumbnailImageForVideo(fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do{
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60), actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
        }catch{
            print("error thumb")
            return nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? URL{
            //choose video
            if let thumbnailImage:UIImage = self.thumbnailImageForVideo(fileUrl: videoUrl) {
                Helper.helper.uploadVideo(fromId: (userCurrent?.uid)!, toId: (userTo?.uid)!, videoUrl: videoUrl, thumbnailImage: thumbnailImage, completion: { (proccess) in
                    self.title = proccess
                })
            }            
        }else{
            //choose image
            var selectedImageFromPicker: UIImage?
            if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker {
                Helper.helper.sendMessImage(image: selectedImage, toId: (userTo?.uid)!, fromId: (userCurrent?.uid)!)
            }
            
        }
        self.dismiss(animated:true, completion: nil)
        self.inputContainerView.alpha = 1
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.inputContainerView.alpha = 1
    }
}







