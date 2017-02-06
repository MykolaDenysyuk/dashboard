//
//  LoginCoordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit


class LoginCoordinator: Coordinator<LoginViewController> {
    
    override var initialControllerIdentifier: String? {
        get {return super.initialControllerIdentifier ?? "login"}
        set {super.initialControllerIdentifier = newValue}
    }
    
    override func run() {
        initialController.delegate = self
        super.run()
    }
}

extension LoginCoordinator: ILoginControllerDelegate {
    internal func loginDataProvider() -> DataProvider<LoginStorage> {
        return LoginDataProvider()
    }

    func loginCompleted(credentials:LoginCredentials) {
        
    }
}


