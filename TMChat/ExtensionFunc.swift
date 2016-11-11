//
//  funcExtension.swift
//  TMDT
//
//  Created by Nguyễn Thanh Tú on 9/13/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func addConstrainWithVisualFormat(VSFormat:String,views:UIView...){
        var dic = Dictionary<String,UIView>()
        for (index,value) in views.enumerated(){
            let key:String = "v\(index)"
            value.translatesAutoresizingMaskIntoConstraints = false
            dic[key] = value
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: VSFormat, options: NSLayoutFormatOptions(), metrics: nil, views: dic))
    }
}

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 44)
    }
}


class LeftPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}

let imageCache = NSCache<AnyObject,AnyObject>()
extension UIImageView{
    func loadImage(urlString:String){
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.color = UIColor.magenta
        activity.frame = CGRect(x: self.frame.size.width / 2, y: self.frame.size.height / 2, width: 0, height: 0)
        self.addSubview(activity)
        activity.startAnimating()
        self.image = UIImage(named: "defaultImage")//nil
        
        //check imageCache
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            activity.stopAnimating()
            return
        }
        
        //othrwise fire off a new download
        let url:URL = URL(string: urlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil{
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                    activity.stopAnimating()
                }
            })
        }).resume()
    }
}
