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
    var state = stateOfVC.hidden
    
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
        coll.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        coll.dataSource = self
        coll.delegate = self
        coll.register(ChatLogCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
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

    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.addSubview(viewNavi)
        self.addSubview(myCollectionView)
        viewNavi.addSubview(lblTitle)
        viewNavi.addSubview(btnDismiss)
        
        
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
        myCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        myCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        myCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

extension ChatLogViewController: UICollectionViewDataSource , UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ChatLogCollectionViewCell
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 15
    }
}

extension ChatLogViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 80)
    }

}













