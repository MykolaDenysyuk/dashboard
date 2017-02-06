//
//  WorldsDatasource.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

struct WorldViewModel {
    let nibName = "WorldViewCell"
    let name: String
    let isOnline: Bool
    let countryName: String
    let countryEmoji: String
    let language: String
    
    var details:String {
        return countryEmoji+" "+countryName+" ("+language+")"
    }
}

protocol IWorldsDatasource {
    /** List of view models to configure row views */
    var models: [WorldViewModel] {get}
    /** Original world item at corresponding to view model index */
    func item(at:IndexPath) -> WorldItem
}

class WorldsDatasource: IWorldsDatasource {

    // MARK: Vars
    
    /** List of original world items */
    private var worlds: [WorldItem]
    let models: [WorldViewModel]
    
    // MARK: Initializer
    
    init(worlds:[WorldItem]) {
        self.worlds = worlds
        var viewModels = [WorldViewModel]()
        for aWorld in worlds {
            let country = NSLocale.system
                .localizedString(forRegionCode: aWorld.countryCode) ?? ""
            let language = NSLocale.system
                .localizedString(forLanguageCode: aWorld.languageCode) ?? ""
            
            let flag = NSLocale.flag(countryCode: aWorld.countryCode)
            
            let viewModel = WorldViewModel(
                name: aWorld.name, isOnline: aWorld.status.id == 3,
                countryName: country,
                countryEmoji: flag,
                language: language)
            viewModels.append(viewModel)
        }
        models = viewModels
    }
    
    // MARK: Accessors
    
    func item(at:IndexPath) -> WorldItem {
        fatalError()
    }
}
