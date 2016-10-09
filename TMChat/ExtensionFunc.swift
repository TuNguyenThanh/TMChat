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
