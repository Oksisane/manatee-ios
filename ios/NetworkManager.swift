//
//  NetworkManager.swift
//  ios
//
//  Created by Ehsan Asdar on 7/25/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var manager: Manager?
    var cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    init() {
        let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
        cfg.HTTPCookieStorage = cookies
        cfg.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always
        manager = Alamofire.Manager(configuration: cfg)
    }
}