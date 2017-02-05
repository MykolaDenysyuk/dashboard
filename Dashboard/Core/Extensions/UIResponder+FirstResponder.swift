//
//  UIResponder+FirstResponder.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

weak var _currentFirstResponder: UIResponder? = nil

extension UIResponder {
    
    /** Finds current first responder if any exists */
    public func currentFirstResponder<T:UIResponder>() -> T? {
        _currentFirstResponder = nil
        let application = UIApplication.shared
        application.sendAction(
            #selector(_findFirstReposnder),
            to: nil,
            from: nil,
            for: nil)
        if let firstResponder = _currentFirstResponder as? T {
            return firstResponder
        }
        return nil
    }
    
    @objc private func _findFirstReposnder() {
        _currentFirstResponder = self
    }
    
    /** finds current first responder and resigns it */
    public func resignFirstResponder_ext() {
        if let firstResponder = currentFirstResponder() {
            firstResponder.resignFirstResponder()
        }
    }
}
