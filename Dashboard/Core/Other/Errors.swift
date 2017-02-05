//
//  Errors.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


func error_abstractMethod() -> Never {
    fatalError("implement in subclasses")
}

func error_wrongType(expected:Any) -> Never {
    fatalError("wrong type, expected \(expected)")
}

func error_impossibleCondition(_ message:String?=nil) -> Never {
    fatalError("improssible to continue execution: \(message ?? "")")
}
