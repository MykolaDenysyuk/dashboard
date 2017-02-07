//
//  WorldViewCellTest.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest
import Dashboard

class WorldViewCellTest: XCTestCase {
    func test_configure() {
        // prepare
        let model = WorldViewModel(
            name: "testName",
            isOnline: true,
            countryName: "countryName",
            countryEmoji: "flagSymbol",
            language: "language")
        
        let cell = (UINib(nibName:"WorldViewCell", bundle:Bundle(for:WorldViewCellTest.self)).instantiate(withOwner: nil).first!) as! WorldViewCell
        
        
        // test
        cell.configureWith(world:model)
        
        // verify
        let match = cell.nameLabel.text == model.name && cell.detailsLabel.text == model.details && cell.isOnline == model.isOnline
        XCTAssert(match, "no all fields are populated from model")
    }
}
