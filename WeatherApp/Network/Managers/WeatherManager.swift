//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/2/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

open class WeatherManager {

    open static let shared = WeatherManager()
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentDayWeather, Error?) -> Void) {
        let model = CurrentDayWeatherModel(latitude: latitude, longitude: longitude)
        RequestManager.addRequest(model).runWithHandler(CurrentDayWeatherHandler()) { (response, error) in
            if error == nil {
                completion((response?.currentDayWeather)! ,nil)
            }
        }
    }
    
    func getHourlyWeather(latitude: Double, longtitude: Double, completion: @escaping ([[HourlyWeather]?], Error?) -> Void) {
        let model = HourlyWeatherModel(latitude: latitude, longitude: longtitude)
        RequestManager.addRequest(model).runWithHandler(HourlyWeatherHandler()) { (response, error) in
            if error == nil {
                completion((response?.hourlyWeatherArray)!, error)
            }
        }
    }
    
    func getNextDaysWeather(latitude: Double, longitude: Double, completion: @escaping ([NextDaysWeather], Error?) -> Void) {
        let model = NextDaysWeatherModel(latitude: latitude, longitude: longitude)
        RequestManager.addRequest(model).runWithHandler(NextDaysWeatherHandler()) { (response, error) in
            if error == nil {
                completion((response?.nextDaysWeatherArray)!, error)
            }
        }
    }
    
    
}
