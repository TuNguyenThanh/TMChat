//
//  Page3CollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class Page3CollectionViewCell: BaseCollectionViewCell {
    
    let cellId:String = "Cell"
    var arrUser:Array<User> = Array<User>()
    var delegate:pushChatLogControllerDelegate?
    var checkSearch:Bool = false
    
    lazy var myTableView:UITableView = {
        let tbl = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(FriendTableViewCell.self, forCellReuseIdentifier: self.cellId)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    let line:UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var colFrientRequest:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 5
        layout.sectionInset.right = 5
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        coll.delegate = self
        coll.dataSource = self
        coll.register(FriendRequestCollectionViewCell.self, forCellWithReuseIdentifier: "CellFriendRequest")
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    
    
    
//    ///hide key touch self
//    func dismissKey(tap : UITapGestureRecognizer){
//        self.endEditing(true)
//        self.checkSearch = false
//        search.setShowsCancelButton(false, animated: true)
//    }
    
    func loadUser(){
        Helper.helper.fetchFriend { (user) in
            self.arrUser.append(user)
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    
    var search:UISearchBar!
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(myTableView)
        self.addSubview(colFrientRequest)
        colFrientRequest.addSubview(line)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|-80-[v0]|", views: myTableView)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: myTableView)
        
        self.colFrientRequest.topAnchor.constraint(equalTo: self.topAnchor,constant: 0).isActive = true
        self.colFrientRequest.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.colFrientRequest.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.colFrientRequest.bottomAnchor.constraint(equalTo: myTableView.topAnchor).isActive = true
        
        self.line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.line.topAnchor.constraint(equalTo: self.colFrientRequest.topAnchor, constant: 0).isActive = true
        self.line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        loadUser()
//      self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Page3CollectionViewCell.dismissKey)))
    }
    
}


extension Page3CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellFriendRequest", for: indexPath) as! FriendRequestCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}


extension Page3CollectionViewCell:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.checkSearch = false
        searchBar.text = ""
        search.setShowsCancelButton(false, animated: true)
        self.arrUser.removeAll()
        loadUser()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        search.setShowsCancelButton(true, animated: true)
        self.checkSearch = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.checkSearch = true
        print(searchText)
        if searchText != "" {
            search.setShowsCancelButton(true, animated: true)
            self.arrUser.removeAll()
            let key:String = searchText
            let t = rootREF.child("User").queryOrdered(byChild: "username").queryEqual(toValue: key)
            t.observe(.childAdded, with:  { (snapshot) in
                print(snapshot)
                DispatchQueue.main.async {
                    if let dic = snapshot.value as? [String:AnyObject]{
                        let user = User(key: snapshot.key, snapshot: dic)
                        //print(user)
                        self.arrUser.append(user)
                    }
                    self.myTableView.reloadData()
                }
            })
            
            if self.arrUser.count == 0{
                self.myTableView.reloadData()
            }
        }else{
            self.arrUser.removeAll()
            loadUser()
        }
    }
}


extension Page3CollectionViewCell: FriendTableViewCellDelegate{
    func sendFriend(uid: String) {
        Helper.helper.sendFriend(uid: uid)
    }
}

extension Page3CollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! FriendTableViewCell
        cell.delegate = self
      
        let user:User = self.arrUser[indexPath.row]
        cell.uid = user.uid
        cell.btnSendFriend.isHidden = true
        
        cell.lblName.text = user.userName
        cell.imgAvatar.loadImage(urlString: user.avatarURL)
        if user.online == false {
            cell.lblOnOff.text = "Offline"
            cell.viewOnOff.backgroundColor = UIColor.gray
        }else{
            cell.lblOnOff.text = "Online"
            cell.viewOnOff.backgroundColor = UIColor.green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.arrUser[indexPath.row]
        self.delegate?.push(userTo: user)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        search = UISearchBar()
        search.placeholder = "Tìm kiếm"
        search.delegate = self
        return search
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y == 0 && checkSearch == false{
////            let appearance = SCLAlertView.SCLAppearance( showCloseButton: false)
////            let alert = SCLAlertView(appearance: appearance)
////            alert.showWait("Load", subTitle: "Vui lòng đợi tý nhé ...")
//            self.arrUser.removeAll()
//            self.loadUser()
////            alert.hideView()
//        }
//    }
}
