//
//  DataProviders.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/7/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation



/** Base DataProvider class */
class DataProvider<T>:IDataProvider {
    
    // MARK: Definitions
    typealias CompletionHandler = (Bool, T?, NSError?) -> ()
    typealias LoadDataTask = (CompletionHandler) -> ()
    
    // MARK: Vars
    var lastData:T?
    var loadDataTask:LoadDataTask?
    
    // MARK: Initializer
    init() {}
    
    // MARK: Actions
    func loadData(onComplete completionBlock: @escaping CompletionHandler) {
        guard
            let task = loadDataTask
            else { error_impossibleCondition("override in subclasses")}
        
        DispatchQueue.global(qos: .background).async {
            func complete(success:Bool, value:T?, err:NSError?) {
                self.lastData = value
                DispatchQueue.main.async {
                    completionBlock(success, value, err)
                }
            }
            task(complete)
        }
    }
}

extension DataProvider {
    /** Init data provider with a task that will be performed async when loadData() is called */
    convenience init(task:@escaping LoadDataTask) {
        self.init()
        loadDataTask = task
    }
}


/** Base class for Data providers that retrieve data using HTTP request */
class RequestableDataProvider<T:ISerializableItem> : DataProvider<T> {
    
    // MARK: Vars
    
    var session = URLSession.shared
    var queue = DispatchQueue.global(qos: .background)
    
    // MARK: Actions
    
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
        var result:T?
        do {
            let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            result = T(plist)
        } catch (let error) {
            return (nil, error as NSError)
        }
        return (result, nil)
    }
}
