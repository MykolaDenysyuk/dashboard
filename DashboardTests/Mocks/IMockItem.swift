//
//  SUTItem.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


protocol IMockItem: class {
    var calledFunctions: [Selector] {get set}
    func didCall(_ function:Selector) -> Bool
    func reset()
}

// MARK: Verification
extension IMockItem {
    func didCall(_ function:Selector) -> Bool {
        for f in calledFunctions {
            if f == function {
                return true
            }
        }
        return false
    }
    
    func reset() {
        calledFunctions.removeAll()
    }
}
