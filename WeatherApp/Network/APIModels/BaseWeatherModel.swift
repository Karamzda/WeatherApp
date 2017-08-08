//
//  BaseWeatherModel.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit

class BaseWeatherModel: RequestModel {
    
    //Base Init class
    override init() {
        super.init()
        self.mainURL = Constants.mainUrl + Constants.WEATHER_API_KEYS.API_KEY + Constants.secureKey
    }
}
