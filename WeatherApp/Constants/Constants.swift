//
//  Constants.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/3/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit

class Constants {
    
    static let secureKey: String = "7d8a71aaa9b7930e"
    static let mainUrl: String = "https://api.wunderground.com"
    
    struct WEATHER_API_KEYS {
        static let API_KEY = "/api/"
        static let HOURLY_WEATHER_KEY = "/hourly/q/"
        static let NEXT_DAYS_WEATHER_KEY = "/forecast10day/q/"
        static let CURRENT_DAY_WEATHER_KEY = "/conditions/q/"
    }
    
    struct JSON_KEYS {
        static let HOURLY_FORECAST = "hourly_forecast"
        static let CURRENT_OBSERVATION = "current_observation"
        static let FORECAST = "forecast"
        static let SIMPLE_FORECAST = "simpleforecast"
        static let FORECAST_DAY = "forecastday"
    }

}
