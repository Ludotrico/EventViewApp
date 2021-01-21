//
//  Extensions.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import Foundation
import UIKit


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor?=nil, centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>?=nil, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor?=nil , centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>?=nil,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
    }
    
    
    
    
    func textContainerView(view: UIView, _ image: UIImage, _ textField: UITextField, lineColor: UIColor) -> UIView {
        view.backgroundColor = .clear
        
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = lineColor
        //imageView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 5, height: 5))
        
        
        
        
        view.addSubview(imageView)
        imageView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.tag = 0
        
        view.addSubview(textField)
        textField.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        textField.tag = 100
        
        let separatorView = UIView()
        separatorView.backgroundColor = lineColor.withAlphaComponent(0.87)
        view.addSubview(separatorView)
        separatorView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
        separatorView.tag = 2
        
        return view
    }
    
    
    func pinEdges(to view: UIView, padding: CGFloat=0) {
        self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
    }
    
    
}


extension UITextField {
    func textField(withPlaceolder placeholder: String?, textColor: UIColor, isSecureTextEntry: Bool, isTextEntry: Bool) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = mediumFont//UIFont.systemFont(ofSize: 16)
        tf.textColor = textColor
        tf.isSecureTextEntry = isSecureTextEntry
        if placeholder != nil {
            tf.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        tf.autocorrectionType = .no
        if isTextEntry {
            tf.keyboardType = .default
        } else {
            tf.keyboardType = .decimalPad
        }
        
        return tf
    }
}

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}


extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func blue() -> UIColor {
        return UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    static func purple() -> UIColor {
        return UIColor.rgb(red: 98, green: 0, blue: 238)
    }
    
    static func pink() -> UIColor {
        return UIColor.rgb(red: 255, green: 148, blue: 194)
    }
    
    static func teal() -> UIColor {
        return UIColor.rgb(red: 3, green: 218, blue: 197)
    }
    
    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 0, green: 150, blue: 255)
    }
    
    static func googleRed() -> UIColor {
        return UIColor.rgb(red: 220, green: 78, blue: 65)
    }
}


extension UIStackView {
    func addBackground(color: UIColor, cornerRadius: CGFloat, borderColor: CGColor?=nil, borderWidth: CGFloat?=nil) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.layer.cornerRadius = cornerRadius
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if borderColor != nil {
            subView.layer.borderColor  = borderColor!
            subView.layer.borderWidth = borderWidth!
        }
        
        insertSubview(subView, at: 0)
        
        
    }
}
