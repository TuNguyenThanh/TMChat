//
//  Page2CollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

protocol Page2CollectionViewCellDelegate {
    func pushCreateGroupController()
}

class Page2CollectionViewCell: BaseCollectionViewCell {
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset.top = 10
        layout.sectionInset.left = 10
        layout.sectionInset.right = 10
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        coll.dataSource = self
        coll.delegate = self
        coll.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    
    lazy var btnCreateGroup:UIButton = {
        let attributeText = NSMutableAttributedString(string: "+", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 32), NSForegroundColorAttributeName: UIColor.white])
        
        let btn = UIButton()
        btn.setAttributedTitle(attributeText, for: UIControlState.normal)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(self.abtnCreateGroup), for: UIControlEvents.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func abtnCreateGroup(){
        print("create group")
        self.delegate1?.pushCreateGroupController()
    }
    
    var delegate:pushChatLogControllerDelegate?
    var delegate1:Page2CollectionViewCellDelegate?
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.addSubview(collectionView)
        self.addSubview(btnCreateGroup)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: collectionView)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: collectionView)
        
        btnCreateGroup.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        btnCreateGroup.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        btnCreateGroup.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnCreateGroup.heightAnchor.constraint(equalTo: btnCreateGroup.widthAnchor).isActive = true
    }
}

extension Page2CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GroupCollectionViewCell
        cell.lblTitle.text = "MTV Group"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.delegate?.push(userTo: "MTV Group")
    }
}

extension Page2CollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize( width: self.frame.width / 2 - 20 , height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }    
}
