//
//  AppCoordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/5/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

/** Root app coordinator. Defines initial flow after appDidFinishLaunching() */
class AppCoordinator {
    
    // MARK: Vars
    var rootWindow:UIWindow
    var rootNavigationController:UINavigationController
    // dependencies
    lazy var loginCoordinator:ICoordinator = {
        return LoginCoordinator(self.rootNavigationController)
    }()
    
    
    // MARK: Initializer
    init() {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootNavigationController = Coordinator.instantiateInitialController("root")
        rootWindow.rootViewController = rootNavigationController
    }
    
    // MARK: Actions
    
    /** Call to start app's navigation flow and present initial screen of the app */
    func run() {
        rootWindow.makeKeyAndVisible()
        loginCoordinator.run()
    }
    
}
