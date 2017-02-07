//
//  CoordinatorMock.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class CoordinatorMock: ICoordinator, IMockItem {
    
    // MARK: Vars
    
    var calledFunctions = [Selector]()
    
    
    // MARK: SUT
    
    required init(_ rootController: UIViewController) {
        //
    }
    
    convenience init() {
        self.init(UIViewController())
    }
    
    @objc func run() {
        calledFunctions.append(#selector(CoordinatorMock.run))
    }
    
    @objc  func reset() {
        calledFunctions.append(#function)
    }
}
