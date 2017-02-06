//
//  WorldItem.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


class WorldItem : ISerializableItem {
    
    // MARK: Vars
    
    let id:Int
    let name: String
    let mapURL: String
    let status:(id:Int, description:String)
    let countryCode:String
    let languageCode:String
    let url:String
    
    // MARK: Initializer
    
    required init?(_ value: Any) {
        guard
            let dict = value as? [String: Any]
            else {return nil}
        
        id = dict.intValue(forKey: "id")
        name = dict.stringValue(forKey: "name")
        mapURL = dict.stringValue(forKey: "mapURL")
        
        if let status = dict["worldStatus"] as? [String: Any] {
            self.status = (status.intValue(forKey: "id"),
                           status.stringValue(forKey: "description"))
        } else {
            status = (0, "")
        }
        
        countryCode = dict.stringValue(forKey: "country")
        languageCode = dict.stringValue(forKey: "language")
        url = dict.stringValue(forKey: "url")        
        
    }
}
