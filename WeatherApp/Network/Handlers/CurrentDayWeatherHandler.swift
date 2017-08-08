//
//  CurrentDayWeatherHandler.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/8/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class CurrentDayWeatherHandler: ResponseHandler {
    
    //MARK: VAR
    var currentDayWeather: CurrentDayWeather?
    
    override init() {
        super.init()
    }
    
    override func parseJSON(_ json: JSON) throws {
        
        switch self.statusCode {
        case 200...203:
            currentDayWeather = CurrentDayWeather(json: json[Constants.JSON_KEYS.CURRENT_OBSERVATION])
            break
        default:
            print("error")
        }
    }

}
