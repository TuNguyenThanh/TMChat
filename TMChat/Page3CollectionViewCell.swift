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
    var arrUserFriend:Array<User> = Array<User>()    //All Friend of userCurrent
    var arrUserFilter:Array<User> = Array<User>()    //Search
    var arrFriendRequest:Array<User> = Array<User>() //All request Friend
    
    var lastContentOffset:CGFloat = 0.0
    var delegate:pushChatLogControllerDelegate?
    var checkupdown:Bool = false
    var checkSearch:Bool = false
    
    lazy var myTableView:UITableView = {
        let tbl = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.separatorColor = UIColor.clear
        tbl.separatorStyle = .none
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
    
    let lblNote:UILabel = {
        let lbl = UILabel()
        lbl.text = "No request"
        lbl.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var colFrientRequest:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 5
        layout.sectionInset.right = 5
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        coll.delegate = self
        coll.dataSource = self
        coll.register(FriendRequestCollectionViewCell.self, forCellWithReuseIdentifier: "CellFriendRequest")
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()

    ///load all user friend of userCurrent
    func loadUserFriend(){
        Helper.helper.fetchFriend { (user) in
            self.arrUserFriend.append(user)
            self.arrUserFilter.append(user)
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    
    ///load request friend
    func loadFriendRequest(){
        Helper.helper.fetchFriendRequest { (uid) in
            //print(uid)
            Helper.helper.fetchUsers(uid: uid, completion: { (user) in
                if user.uid != userCurrent?.uid {
                    if self.arrUserFriend.count != 0 {
                        if self.arrUserFriend.contains(where: {$0.uid != user.uid}){
                            self.arrFriendRequest.append(user)
                        }
                    }else{
                        self.arrFriendRequest.append(user)
                    }
                }
                DispatchQueue.main.async {
                    self.colFrientRequest.reloadData()
                }
            })
        }
    }
    
    var search:UISearchBar!
    var topAnchorSelf:NSLayoutConstraint?
    var topAnchorBottomColl:NSLayoutConstraint?

    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(colFrientRequest)
        self.addSubview(myTableView)
        colFrientRequest.addSubview(line)
        colFrientRequest.addSubview(lblNote)
    
        topAnchorSelf = self.myTableView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0)
        topAnchorSelf?.isActive = true
        
        topAnchorBottomColl = self.myTableView.topAnchor.constraint(equalTo: self.topAnchor,constant: 80)
        topAnchorBottomColl?.isActive = false
        
        self.myTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.myTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.myTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.colFrientRequest.topAnchor.constraint(equalTo: self.topAnchor,constant: 0).isActive = true
        self.colFrientRequest.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.colFrientRequest.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.colFrientRequest.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.line.topAnchor.constraint(equalTo: self.colFrientRequest.topAnchor, constant: 0).isActive = true
        self.line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        self.lblNote.centerXAnchor.constraint(equalTo: colFrientRequest.centerXAnchor).isActive = true
        self.lblNote.centerYAnchor.constraint(equalTo: colFrientRequest.centerYAnchor).isActive = true
        
        loadUserFriend()
        loadFriendRequest() 
    }
}


/*
 // MARK: - CollectionView Request Friend
 */
extension Page3CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.arrFriendRequest.count == 0 {
            self.lblNote.isHidden = false
        }else{
            self.lblNote.isHidden = true
        }
        return self.arrFriendRequest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellFriendRequest", for: indexPath) as! FriendRequestCollectionViewCell
        
        let user = arrFriendRequest[indexPath.row]
        
        cell.imageAvatar.loadImage(urlString: user.avatarURL)
        cell.delegate = self
        cell.uid = user.uid
        cell.indexPath = indexPath.row
        
        if user.online == false {
            cell.viewOnOff.backgroundColor = UIColor.gray
        }else{
            cell.viewOnOff.backgroundColor = UIColor.green
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}

/*
 // MARK: - CollectionView Request Friend Delegate
 */
extension Page3CollectionViewCell: FriendRequestCollectionViewCellDelegate{
    func sendFriendRequest(uid: String, indexPath: Int) {
        let appearance = SCLAlertView.SCLAppearance( showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Bỏ qua") {
        
        }
        alert.addButton("Kết bạn") {
            Helper.helper.saveFriend(uid: uid)
            ///remove item
            self.arrFriendRequest.remove(at: indexPath)
            self.colFrientRequest.reloadData()
        }
        alert.showNotice("Kết bạn", subTitle: "Yêu cầu kết bạn")
    }
}


/*
 // MARK: - Search Bar
*/
extension Page3CollectionViewCell:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.checkSearch = false
        self.endEditing(true)
        searchBar.text = ""
        search.setShowsCancelButton(false, animated: true)
        self.myTableView.reloadData()
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
            self.arrUserFilter.removeAll()
            
            let key:String = searchText
            let t = rootREF.child("User").queryOrdered(byChild: "name").queryEqual(toValue: key)
            t.observe(.childAdded, with:  { (snapshot) in
                print(snapshot)
                DispatchQueue.main.async {
                    if let dic = snapshot.value as? [String:AnyObject]{
                        let user = User(key: snapshot.key, snapshot: dic)
                        self.arrUserFilter.append(user)
                    }
                    self.myTableView.reloadData()
                }
            })
        }
        else{
            self.checkSearch = false
            self.myTableView.reloadData()
        }
    }
}

/*
    // MARK: - Tableview Friend
*/
extension Page3CollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkSearch == false {
            return self.arrUserFriend.count
        }
        return self.arrUserFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! FriendTableViewCell
        cell.delegate = self
        
        var user:User!
        if checkSearch == false {
            user = self.arrUserFriend[indexPath.row]
            ///Check isFriend -> Bool |=> isHiden button send friend request
            cell.btnSendFriend.isHidden = true
        }else{
            user = self.arrUserFilter[indexPath.row]
            if self.arrUserFriend.contains(where: {$0.uid == user.uid}){
                cell.btnSendFriend.isHidden = true
            }else{
                cell.btnSendFriend.isHidden = false
                //bat button ket ban
                 Helper.helper.fetchFriendRequestCheck(uid: user.uid, completion: { (id) in
                    if id == userCurrent?.uid {
                        cell.btnSendFriend.setTitle("Huỷ", for: UIControlState.normal)
                    }
                })
                cell.btnSendFriend.setTitle("Kết bạn", for: UIControlState.normal)
                
            }
            if user.uid == userCurrent?.uid {
                cell.btnSendFriend.isHidden = true
            }
        }
        
        cell.uid = user.uid
        cell.lblName.text = user.name
        
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
        var user:User!
        if checkSearch == false {
            user = self.arrUserFriend[indexPath.row]
            self.delegate?.push(userTo: user)
        }else{
            user = self.arrUserFilter[indexPath.row]
            if self.arrUserFriend.contains(where: {$0.uid == user.uid}){
                self.delegate?.push(userTo: user)
            }
            if user.uid == userCurrent?.uid {
                self.delegate?.push(userTo: user)
            }
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.y)
        if scrollView == myTableView {
            if scrollView.contentOffset.y == 0 && checkupdown == false{
                UIView.animate(withDuration: 0.5, animations: { 
                    self.topAnchorSelf?.isActive = false
                    self.topAnchorBottomColl?.isActive = true
                })
                checkupdown = true
            }else if scrollView.contentOffset.y == 0 && checkupdown == true{
                UIView.animate(withDuration: 0.5, animations: { 
                    self.topAnchorSelf?.isActive = true
                    self.topAnchorBottomColl?.isActive = false
                })
                checkupdown = false
            }
            
            // update the new position acquired
            self.lastContentOffset = scrollView.contentOffset.y
        }
    }
}

/*
 // MARK: - Tableview Friend Delageta
 */
extension Page3CollectionViewCell: FriendTableViewCellDelegate{
    func sendFriend(uid: String) {
        Helper.helper.sendFriendRequest(uid: uid)
    }
    
    func cancelFriendRequest(uid: String) {
        Helper.helper.removeFriendRequest(uid: uid)
    }
    
}




