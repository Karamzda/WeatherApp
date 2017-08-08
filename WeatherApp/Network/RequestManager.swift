//
//  RequestManager.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import Alamofire

open class RequestManager {
    
    //MARK: - LET
    static let shared = RequestManager()
    
    //MARK: - VAR
    
    fileprivate var model: RequestModel = RequestModel()
    fileprivate var parser: ResponseHandler?
    fileprivate(set) fileprivate var alamoFireManager : Alamofire.SessionManager?
    
    var downloadRequest: Alamofire.Request?
    
    open var completionBlock:((_ response: ResponseHandler?, _ error: Error?) -> Void)?
    
    //MARK: - INIT
    fileprivate init()
{
    if self.alamoFireManager == nil
    {
    let configuration = URLSessionConfiguration.default
    //set timeout for request interval
    configuration.timeoutIntervalForRequest = 5
    self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    }
    
    }
    
    public extension RequestManager
    {
        private class func create() -> RequestManager
        {
            return RequestManager()
        }
        
        private func addModel(_ model: RequestModel) -> RequestManager
        {
            self.model = model
            return self;
        }
        
        public class func addRequest(_ request: RequestModel) -> RequestManager
        {
            return self.create().addModel(request)
        }
        
        public func run()
        {
            self.runRequest()
        }
        
        public func runWithHandler<T: ResponseHandler>(_ response: T, completion: ((_ response: T?, _ error: Error?) -> ())?)
        {
            self.parser = response
            if let completion = completion
            {
                self.completionBlock = { (response1, error1) in
                    if let response = response1 as? T
                    {
                        completion(response, error1)
                    }
                    else
                    {
                        completion(nil, error1)
                    }
                }
            }
            
            runRequest()
        }
    }
    
    private extension RequestManager
    {
        func runRequest()
        {
            self.model.finalizeParams()
            
            switch self.model.requestMethod!
            {
            case .get:
                self.runGETRequest()
                break
            }
        }
        
        //GET request function
        private func runGETRequest()
        {
            print(self.model.mainURL)
            
            //       if self.model.showProgress { self.showHUD() }
            
            self.alamoFireManager!.request(self.model.mainURL).response {
                response in
                
                //            if self.model.showProgress { self.hideHUD() }
                
                let urlResponse = response.response
                let data = response.data
                let responseError = response.error
                
                if responseError == nil && data?.count != 0 && self.parser != nil
                {
                    self.parser?.response = data! as AnyObject?
                    self.parser?.statusCode = urlResponse?.statusCode
                    self.parser?.model = self.model
                    self.parser?.completionBlock = {
                        (response: ResponseHandler, parserError: Error?) -> Void in
                        
                        if parserError == nil && self.completionBlock != nil
                        {
                            self.completionBlock!(response, nil)
                        }
                        else if parserError != nil && self.completionBlock != nil
                        {
                            print("parserError")
                            self.completionBlock!(response, parserError)
                        }
                    }
                    
                    self.parser?.decodeRequest()
                }
                else if self.parser == nil
                {
                    print("Response without complection")
                }
                else
                {
                    self.completionBlock!(nil, ResponseError.fatalError)
                }
                
            }
        }

}
