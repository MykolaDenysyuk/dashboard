//
//  Coordinators.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

class Coordinators: XCTestCase {
    
    let testControllerId = "testControllerId"
    
    // MARK: Config
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let controllers = [testControllerId: ViewControllerMock.self]
        StoryboardStub.setup(controllers)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        StoryboardStub.tearDown()
        
        super.tearDown()
    }
    
    

    // MARK: Tests
    
    func test_run() {
        
        // prepare
        
        let rootController = ViewControllerMock()
        let coordinator = Coordinator<ViewControllerMock>(rootController)
        coordinator.initialControllerIdentifier = testControllerId
        
        // test 
        coordinator.run()
        
        // verify
        XCTAssert(rootController.didCall(#selector(UIViewController.show(_:sender:))), "inital controller is presented not from root controller")
    }
    
    func test_reset() {
        
        // prepare
        
        let rootController = ViewControllerMock()
        let coordinator = Coordinator<ViewControllerMock>(rootController)
        coordinator.initialControllerIdentifier = testControllerId
        let initialController = coordinator.initialController
        
        // test
        coordinator.run()
        coordinator.reset()
        
        // verify
        XCTAssert(!initialController.isEqual(coordinator.initialController), "initial controller remains the same after reset")
    }
}
