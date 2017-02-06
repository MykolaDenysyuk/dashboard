//
//  String+Extra.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


extension String {
    
    // Localizable
    
    public var localized:String {
        return localized()
    }
    
    public func localized(_ comment:String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "\(#function)")
    }
}
