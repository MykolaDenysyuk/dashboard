//
//  Coordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

//
// Coordinators are used to incapsulate navigation flow withing the app,
// to handle/transfer events among other screens, etc

/** Base coordinator interface */
protocol ICoordinator {
    /** coordinator should be initialized with root controller */
    init(_ rootController:UIViewController)
    /** call to show first controller of the flow for this coordinator */
    func run()
}

/** Base coordinator with initial controller of generic type */
protocol ICoordinatorWithType: ICoordinator {
    associatedtype InitialControllerType:UIViewController
    
    /** the controller should be shown first if call run() */
    var initialController:InitialControllerType {get set}
    /** the root controller from where navigation flow should begin */
    var rootController:UIViewController {get}
}

/** General coordinator class */
class Coordinator<T:UIViewController>: ICoordinatorWithType {
    var initialControllerIdentifier:String?
    let rootController:UIViewController
    lazy var initialController:T = {
        return self.instantiateInitialController()
    }()
    
    required init(_ rootController:UIViewController) {
        self.rootController = rootController
    }
    
    func run() {
        rootController.show(initialController, sender: self)
    }
    
    
    /** Helper method. By defualt loads controller from main storyboard by
        initialControllerIdentifier */
    func instantiateInitialController() -> T {
        return Coordinator.instantiateInitialController(initialControllerIdentifier)
    }
    
    static func instantiateInitialController(_ initialControllerIdentifier:String?) -> T {
        guard
            let storyboardID = initialControllerIdentifier
            else {error_impossibleCondition("initialControllerIdentifier is required")}
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard
            .instantiateViewController(
                withIdentifier: storyboardID) as? T {
            return controller
        }
        error_wrongType(expected: T.self)
    }
}
