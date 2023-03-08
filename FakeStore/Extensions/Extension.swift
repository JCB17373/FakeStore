//
//  Extension.swift
//  FakeStore
//
//  Created by Aman Bhatt on 08/03/23.
//

import Foundation
import Kingfisher
extension UIImageView{
    func setImage(fromURL url: String?, placeholder: UIImage? = nil) {
        if let urlString = url, let url = URL(string: urlString) {
            var placeHolder = placeholder
           
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            
            self.kf.setImage(with: resource, placeholder: placeHolder, options: nil, progressBlock: nil) { (_) in
                self.backgroundColor = UIColor.white
            }
        } else {
            
        }
    }
}
extension UIView {
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MyAssociatedObjectKeyForTapGesture"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}
extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
