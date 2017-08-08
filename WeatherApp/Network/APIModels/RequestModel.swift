//
//  RequestModel.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import Foundation
import Alamofire

public enum REQUEST_METHOD: String
{
    case get
}

open class RequestModel
{
    //This is main url for request. It can be changed anywere at all sublass
    var mainURL =  "" {
        didSet {
            assert(!mainURL.contains("Optional"), "FOUND OPTIONAL in mainURL \(type(of: self)) ")
        }
    }
    
    var headers: [String : String] = [String : String]()
    var bodyData: [String : Any] = [String : Any]()
    
    var requestMethod: REQUEST_METHOD?
    
    //Base Init class
    init() {}
    
    //Overrife func for generete body for request
    open func finalizeParams(){}
}
