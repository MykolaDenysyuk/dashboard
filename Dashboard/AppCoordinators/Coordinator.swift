//
//  Coordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

/** Base coordinator interface */
protocol ICoordinator: class {
    associatedtype InitialControllerType:UIViewController
    
    var initialControllerIdentifier:String {get}
    var rootController:UIViewController {get}
    var initialController:InitialControllerType {get set}
    
    init(rootController:UIViewController)
    func run()
    
    func instantiateInitialController() -> InitialControllerType
}

extension ICoordinator {
    var rootNavigationController:UINavigationController {
        return AppDelegate.shared.rootNavigationController
    }
    func instantiateInitialController() -> InitialControllerType {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard
            .instantiateViewController(
                withIdentifier: initialControllerIdentifier) as? InitialControllerType {
            return controller
        }
        error_wrongType(expected: InitialControllerType.self)
    }
}

/** General coordinator class */
class Coordinator<T:UIViewController>: ICoordinator {
    var initialControllerIdentifier:String {
        error_abstractMethod()
    }
    let rootController:UIViewController
    lazy var initialController:T = {
        return self.instantiateInitialController()
    }()
    
    required init(rootController:UIViewController) {
        self.rootController = rootController
    }
    
    func run() {
        rootController.show(initialController, sender: self)
    }
}
