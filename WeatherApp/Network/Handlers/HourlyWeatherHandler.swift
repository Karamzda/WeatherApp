//
//  HourlyWeatherHandler.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class HourlyWeatherHandler: ResponseHandler {
    
    //MARK: VAR
    var hourlyWeatherArray: [[HourlyWeather]?] = []
    
    override init() {
        super.init()
    }
    
    override func parseJSON(_ json: JSON) throws {
        
        switch self.statusCode {
        case 200...203:
            
            if let weatherJsonArray = json[Constants.JSON_KEYS.HOURLY_FORECAST].array {
                let firstDayDate = HourlyWeather(json: (weatherJsonArray.first)!).fccTime.date
                for element in weatherJsonArray {
                    let hourlyWeather = HourlyWeather(json: element)
                    let dayDifference = firstDayDate?.days(from: hourlyWeather.fccTime.date)

                    if self.hourlyWeatherArray.count > dayDifference! {
                        self.hourlyWeatherArray[dayDifference!]?.append(hourlyWeather)
                    } else {
                        self.hourlyWeatherArray.append([hourlyWeather])
                    }
                }
            }
            break
        default:
            print("error")
        }
    }

}
