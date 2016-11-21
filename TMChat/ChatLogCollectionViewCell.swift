//
//  ChatLogCollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/9/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit
import AVFoundation

class ChatLogCollectionViewCell: BaseCollectionViewCell {
    
    let txtTextMessages:UITextView = {
        let txt = UITextView()
        txt.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.backgroundColor = UIColor.clear
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isEditable = false
        return txt
    }()
    
    let bubbleView:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        v.layer.cornerRadius = 16
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgAvatar:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 16
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var messImage:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageZoom)))
        return imageView
    }()
    
    lazy var btnPlay:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "play"), for: UIControlState.normal)
        btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.addTarget(self, action: #selector(abtnPlayVideo), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func tapImageZoom(tap:UITapGestureRecognizer){
        print("tap")
        if urlVideo != nil {
            return
        }
        
        if let image = tap.view as? UIImageView {
            self.chatlogViewController?.performZoomImage(image: image)
        }
    }
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    let lblTimestamp:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGray
        lbl.text = "dbjwfhjb"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var playerLayer:AVPlayerLayer?
    var player:AVPlayer?
    
    func abtnPlayVideo(){
        if let url = self.urlVideo {
            player = AVPlayer(url: URL(string: url)!)
            
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bubbleView.bounds
            bubbleView.layer.addSublayer(playerLayer!)
            
            player?.play()
            activityIndicatorView.startAnimating()
            btnPlay.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicatorView.stopAnimating()
    }

    var bubbleViewWith:NSLayoutConstraint?
    var bubbleViewRight:NSLayoutConstraint?
    var bubbleViewLeft:NSLayoutConstraint?
    var chatlogViewController:ChatLogViewController?
    var urlVideo:String?
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(bubbleView)
        self.addSubview(imgAvatar)
        self.addSubview(lblTimestamp)
        bubbleView.addSubview(txtTextMessages)
        bubbleView.addSubview(messImage)
        bubbleView.addSubview(btnPlay)
        bubbleView.addSubview(activityIndicatorView)
        
        messImage.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messImage.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messImage.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        messImage.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        imgAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        imgAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imgAvatar.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imgAvatar.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        ///--
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        bubbleViewRight = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRight?.isActive = true
        
        bubbleViewLeft = bubbleView.leftAnchor.constraint(equalTo: imgAvatar.rightAnchor, constant: 8)
        //bubbleViewLeft?.isActive = false
        
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        bubbleViewWith = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleViewWith?.isActive = true
        
        
        ///----
        txtTextMessages.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        txtTextMessages.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        txtTextMessages.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -8).isActive = true
        txtTextMessages.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        btnPlay.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        btnPlay.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        btnPlay.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnPlay.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lblTimestamp.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblTimestamp.bottomAnchor.constraint(equalTo: self.bubbleView.bottomAnchor, constant: 20).isActive = true
        lblTimestamp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lblTimestamp.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }

}








