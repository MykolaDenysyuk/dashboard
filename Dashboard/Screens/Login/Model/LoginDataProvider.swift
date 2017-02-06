//
//  LoginDataProvider.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/5/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class LoginDataProvider: DataProvider<LoginStorage> {
    override func loadData(onComplete completionBlock: @escaping (Bool, LoginStorage?, NSError?) -> ()) {
        completionBlock(true, LoginStorage(), nil)
    }
}
