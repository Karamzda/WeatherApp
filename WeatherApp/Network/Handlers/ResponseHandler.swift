//
//  ResponseHandler.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum ResponseError: Error
{
    case keyNotFond(String)
    case errorMessage(String)
    case fatalError
    
}

public enum ResponceErrorType: Error
{
    case errorTypeNone
    case errorTypeMessage(String)
    case errorTypeInvalidAccessToken
    case errorTypeInvalidUser
    case errorTypeInvalidData(String)
    case errorTypeInvalidEmail(String)
    case errorTypeInvalidPassword(String)
    case errorTypeInvalidLogin(String)
    case errorTypeInvalidLoginData(String)
    case errorTypeRequestEntityTooLarge
    case errorUnknown
}



open class ResponseHandler
{
    //MARK: VAR
    fileprivate(set) fileprivate var json: JSON!
    
    open var success : Bool = false
    open var response: Any?
    open var error: Error?
    open var statusCode: Int! = 0
    open var model: RequestModel!
    open var completionBlock:((_ response: ResponseHandler, _ error: Error?) -> Void)?
    
    open func decodeRequest()
    {
        do{
            try self.validateResponse()
        }
        catch ResponseError.fatalError
        {
            if self.completionBlock != nil
            {
                self.completionBlock!(self, ResponseError.fatalError)
            }
        }
        catch ResponseError.keyNotFond(let message)
        {
            if self.completionBlock != nil
            {
                self.completionBlock!(self, ResponseError.keyNotFond(message))
            }
        }
        catch ResponseError.errorMessage(let message)
        {
            print("status code ", self.statusCode)
            print("ResponseError.errorMessage")
            if self.completionBlock != nil
            {
                self.completionBlock!(self, ResponseError.errorMessage(message))
            }
        }
        catch
        {
            print("Unknow Error")
        }
    }
    
    func parseJSON(_ json: JSON) throws {}
}

//MARK: - Private

fileprivate extension ResponseHandler
{
    ///Func check response json and return type of action
    fileprivate func validateResponse() throws
    {
        switch self.statusCode
        {
            
            
        case 204:
            if self.completionBlock != nil
            {
                self.completionBlock!(self, nil)
            }
            break
            
        case 200...300:
            
            self.json = JSON(data: self.response! as! Data)
            
            do{
                try self.parseJSON(self.json)
                
                if self.completionBlock != nil
                {
                    self.completionBlock!(self, nil)
                }
            }
            catch ResponseError.keyNotFond(let message)
            {
                throw ResponseError.keyNotFond(message)
            }
            catch ResponseError.errorMessage(let message)
            {
                throw ResponseError.errorMessage(message)
            }
            catch
            {
                throw ResponseError.fatalError
            }
            
            break;
            
        case 400...404:
            print("400")
            self.json = JSON(data: self.response! as! Data)
            
            do{
                try self.parseJSON(self.json)
            }
            catch ResponseError.keyNotFond(let message)
            {
                throw ResponseError.keyNotFond(message)
            }
            catch ResponseError.errorMessage(let message)
            {
                throw ResponseError.errorMessage(message)
            }
            catch
            {
                throw ResponseError.fatalError
            }
        case 413:
            print("413")
            self.json = JSON(data: self.response! as! Data)
            
            do{
                try self.parseJSON(self.json)
            }
            catch ResponseError.keyNotFond(let message)
            {
                throw ResponseError.keyNotFond(message)
            }
            catch ResponseError.errorMessage(let message)
            {
                throw ResponseError.errorMessage(message)
            }
            catch
            {
                throw ResponseError.fatalError
            }
        case 500:
            print("500")
            throw ResponseError.fatalError
            
        default:
            print("statuc code ",self.statusCode)
            throw ResponseError.fatalError
        }
    }
}


