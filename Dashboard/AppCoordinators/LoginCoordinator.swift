//
//  LoginCoordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


class LoginCoordinator: Coordinator<LoginViewController> {
    override func run() {
        initialController.delegate = self
        super.run()
    }
}

extension LoginCoordinator: ILoginControllerDelegate {
    internal func loginDataProvider() -> DataProvider<LoginStorage> {
        error_abstractMethod()
    }

    func loginCompleted(credentials:LoginCredentials) {
        //
    }
}
