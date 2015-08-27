//
//  Retriever.swift
//  ios
//
//  Created by Ehsan Asdar on 2/13/15.
//  Copyright (c) 2015 Ehsan Asdar. All rights reserved.
//

import Foundation
//iOS Swift Lib
import Alamofire

var networkmanager = NetworkManager()
var cooks = networkmanager.cookies
var mgr = networkmanager.manager!
class Retriever{
    static let RESULT_SUCCESS = "SUCCESS!";
    static let RESULT_ERROR = "ERROR";
        class func getAustinisdCookie (username : String, password : String,callback:(String?)->Void){
        let parameters = [
            "cn": username,
            "[password]": password
        ]
        mgr.request(.POST, "https://my.austinisd.org/WebNetworkAuth/", parameters: parameters)
            .response { (request, response, data, error) in
                if (cooks.cookiesForURL(NSURL(string: "http://.austinisd.org")!)?.count > 0 && cooks.cookiesForURL(NSURL(string: "http://.austinisd.org")!)?.first?.name == "CStoneSessionID"){
                    callback(cooks.cookiesForURL(NSURL(string: "http://.austinisd.org")!)!.first!.value!)
                }
                else{
                    callback(self.RESULT_ERROR)
                }
        }
    }
    class func getTEAMSCookie (callback:(String?)->Void){
        mgr.request(.GET, "https://grades.austinisd.org/selfserve/EntryPointSignOnAction.do?parent=false")
            .response { (request, response, data, error) in
                var jsessionidcookie = ""
                for cookie in  cooks.cookies!.generate(){
                    if cookie.name == "JSESSIONID"{
                        jsessionidcookie = cookie.value!!
                    }
                    println(cookie);
                }
                if (count(jsessionidcookie) > 0){
                    callback("JSESSIONID=" + jsessionidcookie)
                }
                else{
                    callback(self.RESULT_ERROR)
                }
        }
        //my-teams.austinisd.org/selfserve/EntryPointSignOnAction.do?parent=false
    }
    class func TEAMSlogin (username:String, password:String, cookies:String?,callback:(String?)->Void){
        mgr.session.configuration.HTTPAdditionalHeaders = [
            "Cookie": cookies!
        ]
        let parameters = [
            "userLoginId": username,
            "userPassword": password
        ]
        mgr.request(.POST, "https://grades.austinisd.org/selfserve/SignOnLoginAction.do",parameters:parameters)
            .response { (request, response, data, error) in
                if error==nil{
                    callback(self.RESULT_SUCCESS)
                }
                else{
                    callback(self.RESULT_ERROR)
                }
            }.responseString { (_, _, string, _) in
                println(string)
        }
        //my-teams.austinisd.org/selfserve/EntryPointSignOnAction.do?parent=false
    }
    //Get cookies and post login using other class methods
    class func login (username:String,password:String,callback:(String?)->Void){
        self.getTEAMSCookie(){
            if ($0 != self.RESULT_ERROR){
                //Got second cookie
                let finalcookie = $0!;
                self.TEAMSlogin(username,password:password,cookies:finalcookie)
                    {
                        if ($0 != self.RESULT_ERROR){
                            callback(finalcookie)
                        }
                        else{
                            callback($0)
                        }
                }
            }
            else{
                callback($0)
            }
        }
    }
    class func getCourses(finalcookie:String,callback:([Course])->Void){
        let params = ["":""]
        self.getTEAMSPage("/selfserve/PSSViewReportCardsAction.do",parameters:params,cookie:finalcookie){
            callback(Parser.parseAverages($0!))
        }
    }
    class func getTEAMSPage(path:String,parameters:[String: String],cookie:String,callback:(String?)->Void){
        mgr.session.configuration.HTTPAdditionalHeaders = [
            "Cookie": cookie
        ]
        mgr.request(.POST, ("https://grades.austinisd.org" + path),parameters:parameters)
            .response { (request, response, data, error) in
                if error != nil{
                    callback(self.RESULT_ERROR)
                }
            }.responseString { (_, _, string, _) in
                callback(string)
        }
    }
}