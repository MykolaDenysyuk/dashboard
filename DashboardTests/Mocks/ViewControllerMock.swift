//
//  ViewControllerMock.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class ViewControllerMock: UIViewController, IMockItem {

    // MARK: Vars
    
    var calledFunctions = [Selector]()
    
    // MARK: SUT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calledFunctions.append(#function)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        present(vc, animated: false, completion: nil)
        calledFunctions.append(#selector(show(_:sender:)))
    }
}
