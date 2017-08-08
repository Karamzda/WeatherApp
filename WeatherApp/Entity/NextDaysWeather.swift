//
//  NextDaysWeather.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class NextDaysWeather {
    
    var day: Int!
    var month: String!
    var year: String!
    
    var tempHigh: String!
    var tempLow: String!
    var condition: String!
    var icon: URL!
    
    
    
    required init(json: JSON) {
        self.day = json["date"]["day"].int
        self.month = json["date"]["month"].string
        self.year = json["date"]["year"].string
        
        self.tempHigh = json["high"]["celsius"].string
        self.tempLow = json["low"]["celsius"].string
        self.condition = json["conditions"].string
        self.icon = json["icon_url"].url
    }

}
