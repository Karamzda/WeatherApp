//
//  HourlyWeatherModel.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit

class HourlyWeatherModel: BaseWeatherModel {
    
    //MARK: VARS
    var latitude: Double?
    var longitude: Double?
    
    override init() {
        super.init()
        self.requestMethod = REQUEST_METHOD.get        
    }
    
    required convenience init(latitude: Double, longitude: Double) {
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override func finalizeParams() {
        self.mainURL += "\(Constants.WEATHER_API_KEYS.HOURLY_WEATHER_KEY)\(latitude!),\(longitude!).json"
    }

}
