//
//  AppCoordinators.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

class AppCoordinators: XCTestCase {
    
    func test_init() {
        let coordinator = AppCoordinator()
        
        XCTAssert(coordinator.rootWindow.rootViewController == coordinator.rootNavigationController, "root controller is not set for the root window")
    }
 
    func test_run() {
        
        // prepare
        let coordinator = AppCoordinator()
        let loginMock = CoordinatorMock()
        let worldsMock = CoordinatorMock()
        coordinator.loginCoordinator = loginMock
        coordinator.worldsCoordinator = worldsMock
        
        // test
        coordinator.run()
        
        // verify
        let loginRun = loginMock.didCall(#selector(CoordinatorMock.run))
        let worldsRun = worldsMock.didCall(#selector(CoordinatorMock.run))
        XCTAssert(loginRun || worldsRun, "none of chiled coordinators were runned")
    }
}
