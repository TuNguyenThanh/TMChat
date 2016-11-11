//
//  Page1CollectionViewCell.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

protocol pushChatLogControllerDelegate {
    func push(userTo:User)
}

class Page1CollectionViewCell: BaseCollectionViewCell {
    
    let cellId:String = "Cell"
    var delegate:pushChatLogControllerDelegate?
    var arrMess:Array<Messages> = Array<Messages>()
    var messagesDictionary:Dictionary<String,Messages> = Dictionary<String,Messages>()
    
    override func setupView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(myTableView)
        
        self.addConstrainWithVisualFormat(VSFormat: "V:|[v0]|", views: myTableView)
        self.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: myTableView)
        
        observeUserMessage()
    }
    
        
    func observeUserMessage(){
        Helper.helper.fetchUserMessages { (mess) in
            print(self.arrMess)
            
            if mess.toId == userCurrent?.uid && mess.fromId != userCurrent?.uid {
                self.messagesDictionary[mess.fromId] = mess
                self.arrMess = Array(self.messagesDictionary.values)
                self.arrMess.sort(by: { (mess1, mess2) -> Bool in
                    return mess1.timestamp.intValue > mess2.timestamp.intValue
                })
            }else if mess.toId != userCurrent?.uid {
                if let toId = mess.toId {
                    self.messagesDictionary[toId] = mess
                    self.arrMess = Array(self.messagesDictionary.values)
                    self.arrMess.sort(by: { (mess1, mess2) -> Bool in
                        return mess1.timestamp.intValue > mess2.timestamp.intValue
                    })
                }
            }
            
            //this will crash because of background thread, so lets call this on dispatch_async main thread
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadTableView), userInfo: nil, repeats: true)
        }
    }

    var timer:Timer?
    func reloadTableView(){
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    lazy var myTableView:UITableView = {
        let tbl = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(HomeTableViewCell.self, forCellReuseIdentifier: self.cellId)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
}

extension Page1CollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! HomeTableViewCell
        let mess = self.arrMess[indexPath.row]
        
        if (mess.toId) != nil {
            if userCurrent?.uid == mess.toId {
                Helper.helper.fetchUsers(uid: mess.fromId, completion: {(user)in
                    DispatchQueue.main.async {
                        cell.lblName.text = user.userName
                        cell.imgAvatar.loadImage(urlString: user.avatarURL)
                    }
                })
            }else{
                Helper.helper.fetchUsers(uid: mess.toId, completion: {(user)in
                    DispatchQueue.main.async {
                        cell.lblName.text = user.userName
                        cell.imgAvatar.loadImage(urlString: user.avatarURL)
                    }
                })
            }
        }
        
        if let seconds = mess.timestamp?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "hh:mm:ss a"
            
            cell.lblTimestamp.text = dateFormater.string(from: timestampDate)
        }
        cell.lblText.text = mess.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mess = self.arrMess[indexPath.row]
        if userCurrent?.uid == mess.toId {
            Helper.helper.fetchUsers(uid: mess.fromId, completion: {(user)in
                self.delegate?.push(userTo: user)            })
        }
        else{
            Helper.helper.fetchUsers(uid: mess.toId, completion: {(user)in
                self.delegate?.push(userTo: user)
            })
        }
    }
}




