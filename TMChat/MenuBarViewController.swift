//
//  MenuViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class MenuBarViewController: BaseView {
    
    let cellId:String = "CellMenu"
    let arrIcon:Array<String> = ["home","chat","friend","setting"]
    
    lazy var collMenuBar:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.showsHorizontalScrollIndicator = false
        coll.backgroundColor = UIColor.clear
        coll.register(MenuBarCollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        coll.dataSource = self
        return coll
    }()
    
    let viewLine:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.layer.cornerRadius = 2
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    var hori:NSLayoutConstraint?
    
    override func setupView(){
        self.addSubview(collMenuBar)
        self.addSubview(viewLine)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: collMenuBar)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: collMenuBar)
        
        viewLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewLine.heightAnchor.constraint(equalToConstant: 5).isActive = true
        viewLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4, constant: 0).isActive =  true
        hori = viewLine.leftAnchor.constraint(equalTo: self.leftAnchor)
        hori?.isActive = true
    }
}

extension MenuBarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! MenuBarCollectionViewCell
        cell.imgMenuView.image = UIImage(named: self.arrIcon[indexPath.row])?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        return cell
    }
}






