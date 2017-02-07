//
//  WorldsDataProvider.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/6/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class WorldsDataProvider: DataProvider<IWorldsDatasource> {

    override func loadData(onComplete completionBlock: @escaping (Bool, IWorldsDatasource?, NSError?) -> ()) {

        let requestable = WorldsRequestableDataProvider()
        requestable.loadData { (success, response, error) in
            guard
                success,
                let response = response
                else {
                    completionBlock(false, nil, error)
                    return
            }
            
            
            DispatchQueue.global(qos: .background).async {
                let datasource = WorldsDatasource(worlds: response.availableWorlds)
                DispatchQueue.main.async {
                    completionBlock(true, datasource, nil)
                }
            }
        }
    }
}


fileprivate class WorldsRequestableDataProvider: RequestableDataProvider<WorldsResponse> {
    
    let path = "http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds"
    
    fileprivate override func buildRequest() -> URLRequest {
        
        guard
            let session = AppDelegate.shared.coordinator.session
            else { error_impossibleCondition("session is required")}
        
        let request = NSMutableURLRequest(url: URL(string: path)!)
        request.httpMethod = "POST"
        var headers = session.defualtHTTPHeaders
        headers["content-type"] = "application/x-www-form-urlencoded"
        request.allHTTPHeaderFields = headers
        
        let postData = NSMutableData(data: "login=\(session.user.login)".data(using: .utf8)!)
        postData.append("&password=\(session.user.password)".data(using: .utf8)!)
        postData.append("&deviceType=\(session.deviceType)".data(using: .utf8)!)
        postData.append("&deviceId=\(session.deviceId)".data(using: .utf8)!)
        
        request.httpBody = postData as Data
        
        return request as URLRequest
    }
}
