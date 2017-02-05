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

/** Base DataProvider class */
class DataProvider<T>:IDataProvider {
    var lastData:T?
    func loadData(onComplete completionBlock: @escaping (_ success:Bool,_ data:T?,_ error:NSError?)->()) {
        error_abstractMethod()
    }
}



/** General interface for objects that can be initialized from any value */
protocol ISerializableItem {
    init?(_ value:Any)
}

/** Base class for Data providers that retrieve data using HTTP request */
class RequestableDataProvider<T:ISerializableItem> : DataProvider<T> {
    var session = URLSession.shared
    var queue = DispatchQueue.global(qos: .background)
    
    func buildRequest() -> URLRequest {
        error_abstractMethod()
    }
    
    override func loadData(onComplete completionBlock: @escaping (Bool, T?, NSError?) -> ()) {
        
        func complete(success:Bool, data:T?, error:Error?) {
            DispatchQueue.main.async {
                completionBlock(success, data, error as? NSError)
            }
        }
        
        let task = session.dataTask(with: buildRequest(), completionHandler: {data, response, error in
            guard
                let data = data
                else {
                    complete(success: false, data: nil, error: error)
                    return
            }
            let result = self.serializeData(data)
            complete(success: result.1==nil, data: result.0, error: result.1)
        })
        task.resume()
    }
    
    func serializeData(_ data:Data) -> (T?, NSError?) {
        error_abstractMethod()
    }
}
