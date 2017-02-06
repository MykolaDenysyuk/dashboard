//
//  Dictionary+Values.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


extension Dictionary where Key: ExpressibleByStringLiteral {
    func string(forKey key:String) -> String? {
        if let string = self[key as! Key] as? String {
            return string
        }
        return nil
    }
    func stringValue(forKey key:String) -> String {
        if let string = self[key as! Key] as? String {
            return string
        }
        return ""
    }
    func intValue(forKey key:String) -> Int {
        if let str = string(forKey: key), let integer = Int(str) {
            return integer
        }
        if let integer = self[key as! Key] as? Int {
            return integer
        }
        return 0
    }
    func boolValue(forKey key:String) -> Bool {
        if let boolean = self[key as! Key] as? Bool {
            return boolean
        }
        return false
    }
}
