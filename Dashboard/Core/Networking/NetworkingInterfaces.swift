//
//  NetworkingInterfaces.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation



/** Base DataProvider interface */
protocol IDataProvider {
    associatedtype DataType
    
    var lastData:DataType? {get}
    func loadData(onComplete completionBlock: @escaping (_ success:Bool,_ data:DataType?,_ error:NSError?)->())
}

/** General interface for objects that can be initialized from any value */
protocol ISerializableItem {
    init?(_ value:Any)
}
