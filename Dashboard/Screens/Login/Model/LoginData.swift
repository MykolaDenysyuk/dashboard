//
//  LoginData.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


class LoginStorage {
    var lastLogin:String?
    // TODO: store in keychain
    var lastPassword:String?
    var isRememberMe = false
}

struct LoginCredentials {
    let login:String
    let password:String
}
