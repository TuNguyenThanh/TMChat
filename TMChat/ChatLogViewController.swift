//
//  ChatLogViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/9/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class ChatLogViewController: BaseView {
    let cellId:String = "Cell"
    var arrMessages:Array<Messages> = Array<Messages>()

    
    let viewNavi:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var btnDismiss:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Dissmiss", for: UIControlState.normal)
        btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.addTarget(self, action: #selector(self.abtnDismiss), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
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
        //btn.setTitleColor(UIColor.black, for: UIControlState.normal)
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
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatLogViewController.aChooseImage(tap:))))
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
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame = CGRect(x: self.frame.width - 10, y: self.frame.height - 10, width: 10, height: 10)
            }, completion: { (true) in
                //maybe we'll do something here later...
                self.removeFromSuperview()
        })
    }
    
    func abtnSend(){
        print(inputTextField.text!)
        inputTextField.text = nil
    }

    func aChooseImage(tap : UITapGestureRecognizer){
        print("abc")
    }
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.addSubview(viewNavi)
        self.addSubview(myCollectionView)
        self.addSubview(inputComponents)
        viewNavi.addSubview(lblTitle)
        viewNavi.addSubview(btnDismiss)
        inputComponents.addSubview(btnSend)
        inputComponents.addSubview(imgChooseImage)
        inputComponents.addSubview(inputTextField)
        inputComponents.addSubview(viewLine)
        
        viewNavi.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewNavi.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        viewNavi.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        viewNavi.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        
        lblTitle.text = usernameSelected
        lblTitle.centerYAnchor.constraint(equalTo: viewNavi.centerYAnchor).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: viewNavi.centerXAnchor).isActive = true
        
        btnDismiss.centerYAnchor.constraint(equalTo: viewNavi.centerYAnchor).isActive = true
        btnDismiss.leftAnchor.constraint(equalTo: viewNavi.leftAnchor, constant: 10).isActive = true

        
        myCollectionView.topAnchor.constraint(equalTo: self.viewNavi.bottomAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        myCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        myCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        inputComponents.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        inputComponents.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputComponents.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
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
        
        
        arrMessages.append(Messages(keyMess: "k1", fromId: "I1", toId: "A1", text: "Hello"))
        arrMessages.append(Messages(keyMess: "k2", fromId: "I1", toId: "A3", text: "Hello say you do"))
        arrMessages.append(Messages(keyMess: "k3", fromId: "I1", toId: "A4", text: "Một bài test đã gây sóng gió cho biết bao nhiêu người,trong đó có cả người bản xứ."))
        arrMessages.append(Messages(keyMess: "k4", fromId: "k1", toId: "A5", text: "Bạn có đủ tự tin để làm bài test này không nào? Thử ngay để biết trình độ tiếng Anh của mình. QuizV-Bài kiểm tra gây sóng gió ngay cả với người bản xứ"))
        

    }

}

extension ChatLogViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ChatLogCollectionViewCell
        
        let messages = self.arrMessages[indexPath.row]
        cell.imgAvatar.image = UIImage(named: "avatar")
        cell.txtTextMessages.text = messages.text
        if messages.fromId == "k1" {
            //outgoing bubble
            cell.bubbleView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.imgAvatar.isHidden = true
        }else{
            //incoming bubble
            cell.bubbleView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.imgAvatar.isHidden = false
        }
        return cell
    }
}

extension ChatLogViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 80
        
        if let isText = self.arrMessages[indexPath.row].text {
            height = estimateFrameForText(text: isText).height + 20
        }
        
        return CGSize(width: self.frame.width, height: height)
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













