//
//  WorldsCoordinator.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class WorldsCoordinator: Coordinator<WorldsViewController> {
    override var initialControllerIdentifier: String? {
        get {return super.initialControllerIdentifier ?? "worlds"}
        set {super.initialControllerIdentifier = newValue}
    }
    
    override func run() {
        initialController.delegate = self
        super.run()
    }
}


extension WorldsCoordinator: IWorldsViewControllerDelegate {
    func worldsDataProvider() -> DataProvider<IWorldsDatasource> {
        return WorldsDataProvider()
    }
    
    func didSelect(aWorld: WorldItem, at index: IndexPath) {
        // todo
    }
}
