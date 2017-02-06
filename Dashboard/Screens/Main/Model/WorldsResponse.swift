//
//  WorldsResponse.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation

class WorldsResponse : ISerializableItem {
    
    // MARK: Definitions
    
    struct Features {
        let helpShift: Bool
        let appleTvSync: Bool
        let directPlay: Bool
    }
    
    struct Logins {
        let google: Bool
        let facebook: Bool
    }
    
    // MARK: Vars
    
    let features: Features
    let loginSwitchers: Logins
    let serverVersion: String
    private(set) var time: Date?
    let availableWorlds: [WorldItem]
    
    
    // MARK: Initializer
    
    required init?(_ value: Any) {
        guard
            let dict = value as? [String: Any]
            else {return nil}
        
        let tvSync = dict.boolValue(forKey: "featureAppleTVSynchronisation")
        let directPlay = dict.boolValue(forKey: "featureDirectPlay")
        let helpShift = dict.boolValue(forKey: "featureHelpshift")
        
        features = Features(
            helpShift: helpShift,
            appleTvSync: tvSync,
            directPlay: directPlay)
        
        let google = dict.boolValue(forKey: "googleLoginSwitchOn")
        let facebook = dict.boolValue(forKey: "facebookLoginSwitchOn")
        
        loginSwitchers = Logins(google: google, facebook: facebook)
        
        serverVersion = dict.stringValue(forKey: "serverVersion")
        
        let dateFormatter = DateFormatter()
        // "2017-02-06 19:06:25 Etc/GMT"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
        if let dateString = dict["time"] as? String {
            time = dateFormatter.date(from: dateString)
        }
        
        var worlds = [WorldItem]()
        
        if let rawWorlds = dict["allAvailableWorlds"] as? [Any] {
            for raw in rawWorlds {
                if let aWorld = WorldItem(raw) {
                    worlds.append(aWorld)
                }
            }
        }
        availableWorlds = worlds
    }
}
