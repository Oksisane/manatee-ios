//
//  Networking.swift
//  manateams-ios
//
//  Created by Ehsan Asdar on 12/13/14.
//  Copyright (c) 2014 patil215. All rights reserved.
//

import Foundation
import SwiftHTTP

class TEAMSGradRetriever{
    typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

    func postPageHttps(url:String,onCompletion: ServiceResponse) -> Void{
        var request = HTTPTask()
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
                let responseDict = response.responseObject as NSDictionary
                // Note: This is where you would serialize the nsdictionary in the responseObject into one of your own model classes (or core data classes)
                onCompletion(responseDict, nil)
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                onCompletion(nil, error)
        })
    }
}

