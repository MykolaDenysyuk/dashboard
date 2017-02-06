//
//  Session.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

struct LoginCredentials {
    let login:String
    let password:String
}


struct Session {
    
    let user:LoginCredentials
    let defualtHTTPHeaders = [String:String]()
    
    let deviceType = "\(UIDevice.current.model) - \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
    let deviceId = NSUUID().uuidString
}
