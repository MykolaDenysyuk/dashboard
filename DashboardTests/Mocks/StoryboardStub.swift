//
//  StoryboardStub.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class StoryboardStub: UIStoryboard {
    // MARK: Vars
    
    var controllers = [String: UIViewController.Type]()
 
    // MARK: Stubbed
    
    override func instantiateInitialViewController() -> UIViewController? {
        if let type = controllers.first?.value {
            return type.init()
        }
        return nil
    }
    
    override func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        return controllers[identifier]!.init()
    }
    
    // MARK: Config
    
    private static var defualtStoryboard:UIStoryboard!
    
    static func setup(_ viewControllers:[String:UIViewController.Type] = [:]) {
        defualtStoryboard = currentMain
        let stub = StoryboardStub()
        stub.controllers = viewControllers
        currentMain = stub
    }
    
    static func tearDown() {
        currentMain = defualtStoryboard
    }
}
