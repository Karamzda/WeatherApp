//
//  HourlyWeatherHandler.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class NextDaysWeatherHandler: ResponseHandler {
    
    //MARK: VAR
    var nextDaysWeatherArray: [NextDaysWeather] = []
    
    override init() {
        super.init()
    }
    
    override func parseJSON(_ json: JSON) throws {
        
        switch self.statusCode {
        case 200...203:
            if let weatherJsonArray = json[Constants.JSON_KEYS.FORECAST][Constants.JSON_KEYS.SIMPLE_FORECAST][Constants.JSON_KEYS.FORECAST_DAY].array {
                for element in weatherJsonArray {
                    self.nextDaysWeatherArray.append(NextDaysWeather(json: element))
                }
            }
            break
        default:
            print("error")
        }
    }
    
}
