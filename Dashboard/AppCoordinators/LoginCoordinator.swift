//
//  LoginCoordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol ILoginCoordinatorDelegate: class {
    func loginCompleted(credentials:LoginCredentials)
}

class LoginCoordinator: Coordinator<LoginViewController> {
    
    // MARK: Vars
    
    weak var delegate:ILoginCoordinatorDelegate!
    
    // MARK: Actions
    
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
        let dataProvider = DataProvider<LoginStorage> { (complete) in
            complete(true, LoginStorage(), nil)
        }
        return dataProvider
    }

    func loginCompleted(credentials:LoginCredentials) {
        delegate.loginCompleted(credentials: credentials)
    }
}


