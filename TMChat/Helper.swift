//
//  Helper.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/30/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

let rootREF = FIRDatabase.database().reference()
var userCurrent:User?


class Helper {
    static let helper = Helper()
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    
    private var _USER_REF = rootREF.child("User")
    private var _MESSAGES_REF = rootREF.child("Messages")
    private var _CONVERSATION_REF = rootREF.child("Conversation")
    private var _USER_MESSAGES_REF = rootREF.child("User-Messages")
    private var _STORAGE_REF = FIRStorage.storage().reference()
    
    var USER_REF : FIRDatabaseReference{
        return _USER_REF
    }
    
    var MESSAGES_REF : FIRDatabaseReference{
        return _MESSAGES_REF
    }
    
    var USER_MESSAGES_REF : FIRDatabaseReference{
        return _USER_MESSAGES_REF
    }
    
    var CONVERSATION_REF : FIRDatabaseReference{
        return _CONVERSATION_REF
    }
    
    var STORAGE_REF:FIRStorageReference{
        return _STORAGE_REF
    }
    
    ///Check email
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    ///Check Login Email
    func checkInputLogin(email:String, pass:String) -> Bool{
        var check:Bool = false
        let alert = SCLAlertView()
        if email == "" {
            alert.showError("Lỗi", subTitle: "Vui lòng nhập Email", closeButtonTitle: "Thử lại")
        } else {
            //Kiem tra chuoi nhap co phai la email khong
            if isValidEmail(testStr: email) == false {
                alert.showError("Lỗi", subTitle: "Đây không phải là Email", closeButtonTitle: "Thử lại")
            }else{
                if pass == "" {
                    alert.showError("Lỗi", subTitle: "Vui lòng nhập mật khẩu", closeButtonTitle: "Thử lại")
                }else{
                    check = true
                }
            }
        }
        return check
    }
    
    ///Check Register
    func checkInputRegister(name:String, email:String, pass:String) -> Bool {
        var check = false
        let alert = SCLAlertView()
        //Check name
        if name == ""{
            alert.showError("Lỗi", subTitle: "Vui lòng nhập tên", closeButtonTitle: "Thử lại")
        }else{
            //Check email
            if email == ""{
                alert.showError("Lỗi", subTitle: "Vui lòng nhập Email", closeButtonTitle: "Thử lại")
            }else{
                //Kiem tra chuoi nhap co phai la email khong
                if isValidEmail(testStr: email) == false {
                    alert.showError("Lỗi", subTitle: "Đây không phải là Email", closeButtonTitle: "Thử lại")
                }else{
                    //Check pass
                    if pass == ""{
                        alert.showError("Lỗi", subTitle: "Vui lòng nhập mật khẩu", closeButtonTitle: "Thử lại")
                    }else{
                        //Thoa yeu cau
                        check = true
                    }
                }
            }
        }
        return check
    }

    
    ///Show message error Firebase
    func errorFirebase(code:Int){
        let alert = SCLAlertView()
        switch code {
        case 17007:
            alert.showError("Thông báo", subTitle: "Email này đã có người đăng ký", closeButtonTitle: "Thử lại")
        case 17009:
            alert.showError("Thông báo", subTitle: "Mật khẩu không hợp lệ",closeButtonTitle: "Thử lại")
        case 17011:
            alert.showError("Thông báo", subTitle: "Email không tồn tại", closeButtonTitle: "Thử lại")
        case 17026:
            alert.showError("Thông báo", subTitle: "Mật khẩu phải nhiều hơn 6 ký tự", closeButtonTitle: "Thử lại")
        case 17020:
            alert.showError("Thông báo", subTitle: "Kết nối bị gián đoạn, kiểm tra kết nối Internet", closeButtonTitle: "Thử lại")
        case 17008:
            alert.showError("Thông báo", subTitle: "Đây không phải là Email", closeButtonTitle: "Thử lại")
            
        default:
            alert.showError("Thông báo", subTitle: code.description)
            print(code.description)
        }
    }
    
    ///Return user, No user is signed in return nil
    func checkUserLogin(completion:(Any?)->()){
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            completion(user.uid)
            
        } else {
            // No user is signed in.
            print("No user is signed in.")
            completion(nil)
        }
    }
    
    ///Login Facebook
    func loginFB(completion:@escaping (Bool)->()) {
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: nil , handler:  { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                return
            }
            
            let alert = SCLAlertView(appearance: self.appearance)
            alert.showWait("Đăng Nhập", subTitle: "Vui lòng đợi tý nhé ...")
            if let result = result {
                if let token = result.token.tokenString {
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: token)
                    
                    FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                        if error != nil {
                            print(error?.localizedDescription ?? "error")
                            return
                        } else if let user = user {
                            let uid:String = user.uid
                            let displayName:String = user.displayName != nil ? user.displayName! : "Facebook's user"
                            let email:String = user.email != nil ? user.email! : "Email of Facebook's user"
                            let urlPhoto:String = (user.photoURL?.absoluteString)!
                            
                            let infoUser:[String:Any] = ["email":email, "name":displayName, "numberPhone": "+84", "avatarURL":urlPhoto, "online":false] as [String:Any]
                            self.USER_REF.child(uid).setValue(infoUser)
                            userCurrent = User(key: uid, snapshot: infoUser as Dictionary<String, AnyObject>)
                            alert.hideView()
                            completion(true)
                        }
                    })
                }else{
                    print("error")
                }
            }
        })
    }
    
    ///Logout success return true
    func logout(completion:@escaping (Bool)->()){
        let alert = SCLAlertView()
        alert.addButton("Đăng Xuất") {
            do {
                self.offline()
                try FIRAuth.auth()!.signOut()
                completion(true)
            }catch let error {
                print(error)
                completion(false)
            }
        }
        alert.showWarning("Đăng Xuất", subTitle: "Bạn có muốn đăng xuất ?", closeButtonTitle: "Huỷ")
    }
    
    ///Info User Current
    func fetchUserCurrent(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        print("uid = \(uid)")
        USER_REF.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dic = snapshot.value as? [String:AnyObject] {
                print(dic)
                let user = User(key: snapshot.key, snapshot: dic )
                userCurrent = user
            }
        },withCancel: nil)
    }
    
    ///Info User
    func fetchUsers(completion:@escaping (User)->()){
        self.USER_REF.observe(.childAdded, with: { (snapshot) in
            if let dic = snapshot.value as? [String:AnyObject]{
                let user = User(key: snapshot.key, snapshot: dic)
                completion(user)
            }
        }, withCancel: nil)
    }
    
    ///Fetch Friend
    func fetchFriend(completion:@escaping (User)->()){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        rootREF.child("Friend").child(uid).observe(.childAdded, with: { (snapshot) in
            //print(snapshot.key)
            self.USER_REF.child(snapshot.key).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dic = snapshot.value as? [String:AnyObject] {
                    //print(dic)
                    let user = User(key: snapshot.key, snapshot: dic)
                    completion(user)
                }
            },withCancel: nil)
        })
    }
    
//    func sendFriend(uid:String){
//        rootREF.child("Friend").child((userCurrent?.uid)!).updateChildValues([uid:"1"])
//    }

    func fetchFriendRequestCheck(uid:String,completion:@escaping (String)->()){
        rootREF.child("FriendRequest").child(uid).observe(.childAdded, with: {(snapshot) in
            completion(snapshot.key)
        })
    }
    
    func sendFriendRequest(uid:String){
        rootREF.child("FriendRequest").child((userCurrent?.uid)!).observe(.childAdded, with: {(snapshot) in
            print(snapshot.key)
            if snapshot.key == "" {
                rootREF.child("FriendRequest").child(uid).updateChildValues([(userCurrent?.uid)!:"1"])
            }else{
                rootREF.child("Friend").child((userCurrent?.uid)!).updateChildValues([uid:"1"])
                rootREF.child("FriendRequest").child((userCurrent?.uid)!).child(uid).removeValue()
                rootREF.child("FriendRequest").child(uid).child((userCurrent?.uid)!).removeValue()
            }
            return
        })
        rootREF.child("FriendRequest").child(uid).updateChildValues([(userCurrent?.uid)!:"1"])
    }
    
    func saveFriend(uid:String){
         rootREF.child("Friend").child((userCurrent?.uid)!).updateChildValues([uid:"1"])
         rootREF.child("Friend").child(uid).updateChildValues([(userCurrent?.uid)!:"1"])
         rootREF.child("FriendRequest").child((userCurrent?.uid)!).child(uid).removeValue()
    }
    
    func removeFriendRequest(uid:String){
        rootREF.child("FriendRequest").child(uid).child((userCurrent?.uid)!).removeValue()
    }
    
    func fetchFriendRequest(completion:@escaping (String)->()){
        rootREF.child("FriendRequest").child((userCurrent?.uid)!).observe(.childAdded, with: {(snapshot) in
            completion(snapshot.key)
        })
    }
    
    ///Sign in user with email TMChat - login success return true
    func loginEmail(email:String, password:String, completion:@escaping (Bool)->()){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Đăng Nhập", subTitle: "Vui lòng đợi tý nhé ...")
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                alert.hideView()
                print(error.localizedDescription)
                self.errorFirebase(code: error._code)
                return
            }
            
            if let user = user {
                let uid:String = user.uid
                let displayName:String = user.displayName!
                let email:String = user.email!
                let urlPhoto:String = (user.photoURL?.absoluteString)!
                
                let infoUser:[String:Any] = ["email":email, "name":displayName, "numberPhone": "+84", "avatarURL":urlPhoto, "online":false] as [String:Any]
                userCurrent = User(key: uid, snapshot: infoUser as Dictionary<String, AnyObject>)
                alert.hideView()
                completion(true)
            }
        })
    }
    
    ///Sign up user with email TMChat
    func registerUser(name:String, email:String, password:String, imgAvatar:UIImageView, completion:@escaping (Bool)->()){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Đăng Ký", subTitle: "Vui lòng đợi tí nhé ...")
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            //check error
            if let error = error {
                alert.hideView()
                print(error.localizedDescription)
                self.errorFirebase(code: error._code)
                return
            }
            
            //not error & have user
            if let user = user {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = name
                
                //upload image
                let metadata = FIRStorageMetadata()
                metadata.contentType = "image/jpeg"
                
                var dataSize:Data = UIImageJPEGRepresentation(imgAvatar.image!,1.0)!
                if dataSize.count > 3000 {
                    dataSize = UIImageJPEGRepresentation(imgAvatar.image!,0.1)!
                }else if dataSize.count > 2000{
                    dataSize = UIImageJPEGRepresentation(imgAvatar.image!,0.3)!
                }else if dataSize.count > 1000 {
                    dataSize = UIImageJPEGRepresentation(imgAvatar.image!,0.5)!
                }

                self.STORAGE_REF.child("profileImage/\(user.uid)").put(dataSize, metadata: metadata, completion: { (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    let fileUrl:String = metadata!.downloadURLs![0].absoluteString
                    changeRequest.photoURL = URL(string: fileUrl)
                    changeRequest.commitChanges(completion: { (error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }
                    })
                    
                    let infoUser:[String:Any] = ["email":email, "name":name, "numberPhone": "+84", "avatarURL":fileUrl, "online":false] as [String:Any]
                    ///create node in database
                    self.USER_REF.child(user.uid).setValue(infoUser, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print(error ?? "error")
                        }
                        
                        alert.hideView()
                        //return true when not error
                        completion(true)
                    })
                })
             
            }
        }
    }
    
    func online(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        self.USER_REF.child(uid).child("online").setValue(true)
    }

    func offline(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        self.USER_REF.child(uid).child("online").setValue(false)
    }
    
    ///Password reset email sent.
    func resetPasswordToEmail(){
        let alert = SCLAlertView()
        alert.addButton("Đồng ý") {
            FIRAuth.auth()?.sendPasswordReset(withEmail: (userCurrent?.email)!) { error in
                if error != nil {
                    // An error happened.
                    print(error ?? "error")
                    self.errorFirebase(code: (error?._code)!)
                } else {
                    // Password reset email sent.
                    DispatchQueue.main.async {
                        let alert1 = SCLAlertView()
                        alert1.showSuccess("Thành Công 😎", subTitle: "Vui lòng kiểm tra Email \((userCurrent?.email)!)", closeButtonTitle: "Đồng ý")
                    }
                }
            }
        }
        alert.showWarning("Đặt lại mật khẩu", subTitle: "Bạn có muốn Đặt lại mật khẩu?", closeButtonTitle: "Huỷ")
    }
    
    func forgotPassword(email:String){
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email) { error in
            if error != nil {
                // An error happened.
                print(error ?? "error")
                self.errorFirebase(code: (error?._code)!)
            } else {
                // Password reset email sent.
                DispatchQueue.main.async {
                    let alert1 = SCLAlertView()
                    alert1.showSuccess("Thành Công 😎", subTitle: "Vui lòng kiểm tra Email \(email)", closeButtonTitle: "Đồng ý")
                }
            }
        }
    }

    ///Update Profile User
//    func updateUser(name:String? ,numberPhone:String?, imgAvatar:UIImageView?){
//        let alert = SCLAlertView(appearance: appearance)
//        alert.showWait("Loading", subTitle: "Vui lòng đợi tí nhé ...")
//        
//        let user = FIRAuth.auth()?.currentUser
//        if let user = user {
//            let changeRequest = user.profileChangeRequest()
//            changeRequest.displayName = name
//            changeRequest.commitChanges(completion: { (error) in
//                if let error = error{
//                    print(error.localizedDescription)
//                    return
//                }
//            })
//            
//            let filePath = "profileImage/\(user.uid)"
//            let metadata = FIRStorageMetadata()
//            metadata.contentType = "image/jpeg"
//            if let uploadData = UIImagePNGRepresentation((imgAvatar?.image)!){
//                self.STORAGE_REF.child(filePath).put(uploadData, metadata: metadata, completion: { (metadata, error) in
//                    if let error = error {
//                        print("\(error.localizedDescription)")
//                        return
//                    }
//                    let fileUrl = metadata!.downloadURLs![0].absoluteString
//                    let changeRequestPhoto = user.profileChangeRequest()
//                    changeRequestPhoto.photoURL = URL(string: fileUrl)
//                    changeRequestPhoto.commitChanges(completion: { (error) in
//                        if let error = error {
//                            print(error.localizedDescription)
//                            return
//                        }else{
//                            alert.hideView()
//                            DispatchQueue.main.async {
//                                let alertSuccess = SCLAlertView()
//                                alertSuccess.showSuccess("Thành Công 😎", subTitle: "Thông tin đã được cập nhật", closeButtonTitle: "Đồng ý")
//                            }
//                            print ("profile update")
//                        }
//                    })
//                    self.USER_REF.child(user.uid).updateChildValues(["name":name!, "numberPhone": numberPhone!, "avatarURL":fileUrl])
//                })
//            }
//        }
//    }
    
    ///Update New name Current
    func updateName(name:String){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Loading", subTitle: "Vui lòng đợi tí nhé ...")
        
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
            })
            
            self.USER_REF.child(user.uid).updateChildValues(["name":name])
            alert.hideView()
            DispatchQueue.main.async {
                let alertSuccess = SCLAlertView()
                alertSuccess.showSuccess("Thành Công 😎", subTitle: "Thông tin đã được cập nhật", closeButtonTitle: "Đồng ý")
            }
        }
    }
    
    ///Update New Number Phone
    func updateNumberPhone(numberPhone:String){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Loading", subTitle: "Vui lòng đợi tí nhé ...")
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        self.USER_REF.child(uid!).updateChildValues( ["numberPhone": numberPhone])
        alert.hideView()
        DispatchQueue.main.async {
            let alertSuccess = SCLAlertView()
            alertSuccess.showSuccess("Thành Công 😎", subTitle: "Thông tin đã được cập nhật", closeButtonTitle: "Đồng ý")
        }
    }
    
    
    ///Update New Avatar Usercurrent
    func updateAvatarImage(imgAvatar:UIImageView){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Loading", subTitle: "Vui lòng đợi tí nhé ...")
        
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            let filePath = "profileImage/\(user.uid)"
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            var dataSize:Data = UIImageJPEGRepresentation(imgAvatar.image!,1.0)!
            if dataSize.count > 3000 {
                dataSize = UIImageJPEGRepresentation(imgAvatar.image!,0.1)!
            }else if dataSize.count > 2000{
                dataSize = UIImageJPEGRepresentation(imgAvatar.image!,0.3)!
            }else if dataSize.count > 1000 {
                dataSize = UIImageJPEGRepresentation(imgAvatar.image!,0.5)!
            }
            
            self.STORAGE_REF.child(filePath).put(dataSize, metadata: metadata, completion: { (metadata, error) in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                let fileUrl = metadata!.downloadURLs![0].absoluteString
                let changeRequestPhoto = user.profileChangeRequest()
                changeRequestPhoto.photoURL = URL(string: fileUrl)
                changeRequestPhoto.commitChanges(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }else{
                        alert.hideView()
                        DispatchQueue.main.async {
                            let alertSuccess = SCLAlertView()
                            alertSuccess.showSuccess("Thành Công 😎", subTitle: "Thông tin đã được cập nhật", closeButtonTitle: "Đồng ý")
                        }
                        print ("profile update")
                    }
                })
                self.USER_REF.child(user.uid).updateChildValues(["avatarURL":fileUrl])
            })
        }
    }
    
    ///send message image
    func sendMessImage(image:UIImage, toId:String, fromId:String){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Loading", subTitle: "Vui lòng đợi tí nhé ...")
        if let uploadData = UIImageJPEGRepresentation(image, 0.2){
            let imageName = UUID().uuidString
            self.STORAGE_REF.child("Messages-Images").child(imageName).put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error up image")
                    return
                }
                let imageUrl = metadata!.downloadURLs![0].absoluteString
                print(imageUrl)
                let timestamp = Date().timeIntervalSince1970
                let values = ["type":"IMAGE", "urlImage":imageUrl, "fromId": fromId, "toId": toId, "timestamp": timestamp, "imageWidth": image.size.width, "imageHeight": image.size.height] as [String : Any]
                let ref = self.MESSAGES_REF.childByAutoId()
                ref.updateChildValues(values ,withCompletionBlock: { (error, ref) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    let messageId = ref.key
                    self.USER_MESSAGES_REF.child(fromId).updateChildValues([messageId:"1"])
                    self.USER_MESSAGES_REF.child(toId).updateChildValues([messageId:"1"])
                    alert.hideView()
                })

            })
        }
    }
    
    func fetchUsers(uid:String, completion:@escaping (User)->()){
        USER_REF.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dic = snapshot.value as? [String:AnyObject] {
                let user = User(key: snapshot.key, snapshot: dic )
                completion(user)
            }
        },withCancel: nil)
    }
    

    func fetchMess(completion:@escaping (Messages)->()){
        self.MESSAGES_REF.observe(.childAdded, with: {(snapshot) in
            if let dic = snapshot.value as? [String:AnyObject]{
                let mess = Messages(key: snapshot.key, snapshot: dic)
                completion(mess)
            }
        })
    }
    
    
    func fetchUserMessages(completion:@escaping (Messages)->()){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return}
        self.USER_MESSAGES_REF.child(uid).queryLimited(toLast: 10).observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            print(messageId)
            self.MESSAGES_REF.child(messageId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dic = snapshot.value as? [String: AnyObject] {
                    let message = Messages(key: snapshot.key, snapshot: dic)
                    completion(message)
                }
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    func sendMessage(text:String, toId:String, fromId:String){
        let timestamp = Date().timeIntervalSince1970
        let values = ["type":"TEXT", "text":text,"fromId": fromId, "toId": toId, "timestamp": timestamp] as [String : Any]
        let ref = self.MESSAGES_REF.childByAutoId()
        ref.updateChildValues(values ,withCompletionBlock: { (error, ref) in
            if let error = error {
                print(error)
                return
            }
            
            let messageId = ref.key
            self.USER_MESSAGES_REF.child(fromId).updateChildValues([messageId:"1"])
            self.USER_MESSAGES_REF.child(toId).updateChildValues([messageId:"1"])
        })
    }
    
    
    func uploadVideo(fromId:String, toId:String, videoUrl:URL, thumbnailImage:UIImage, completion:@escaping (String)->()){
        let alert = SCLAlertView(appearance: appearance)
        alert.showWait("Loading", subTitle: "Vui lòng đợi tí nhé ...")
        
         let timestamp = Date().timeIntervalSince1970
        let filename = "Video/\(timestamp).mov"
        let uploadTask = self.STORAGE_REF.child(filename).putFile(videoUrl, metadata: nil, completion: { (metadata, error) in
            if error != nil {
                print(error ?? "upload video error")
                return
            }
            
            if let storageUrl = metadata?.downloadURL()?.absoluteString {
                //print(storageUrl)
                //upload image of video
                if let uploadData = UIImageJPEGRepresentation(thumbnailImage, 0.2){
                    let imageName = UUID().uuidString
                    self.STORAGE_REF.child("Messages-Images").child(imageName).put(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error?.localizedDescription ?? "error up image")
                            return
                        }
                        let imageUrl = metadata!.downloadURLs![0].absoluteString
                        
                        //save database
                        let values = ["type":"VIDEO", "urlVideo":storageUrl, "urlImage": imageUrl, "fromId": fromId, "toId": toId, "timestamp": timestamp, "imageWidth": thumbnailImage.size.width, "imageHeight": thumbnailImage.size.height] as [String : Any]
                        
                        let ref = self.MESSAGES_REF.childByAutoId()
                        ref.updateChildValues(values ,withCompletionBlock: { (error, ref) in
                            if let error = error {
                                print(error)
                                return
                            }
                            
                            let messageId = ref.key
                            self.USER_MESSAGES_REF.child(fromId).updateChildValues([messageId:"1"])
                            self.USER_MESSAGES_REF.child(toId).updateChildValues([messageId:"1"])
                        })
                    })
                }
            }
        })
        
        uploadTask.observe(.progress, handler: {(snapshot) in
            if let completedUnitCount = snapshot.progress?.completedUnitCount{
                completion(String(completedUnitCount))
            }
        })
        
        uploadTask.observe(.success, handler: {(snapshot) in
            completion((userCurrent?.name)!)
            alert.hideView()
        })
    }
    
    
   

    
    
}








