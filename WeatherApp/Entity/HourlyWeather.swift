//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/3/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class HourlyWeather {
    
    var fccTime: FccTime!
    
    var temp: String!
    var dewpoint: String!
    var condition: String!
    var iconUrl: URL!
    var fctCode: String!
    var sky: String!
    var wspd: String!
    var wdir: String!
    var wx: String!
    var uvi: String!
    var humiditi: String!
    var feelsLike: String!
    var snow: String!
    var pop: String!
    var mslp: String!
    
    
    required init(json: JSON) {
        
        self.fccTime = FccTime(json: json["FCTTIME"])
        
        self.temp = json["temp"]["metric"].string
        self.dewpoint = json["dewpoint"]["metric"].string
        self.condition = json["condition"].string
        self.iconUrl = json["icon_url"].url
        self.fctCode = json["fctcode"].string
        self.sky = json["sky"].string
        self.wspd = json["wspd"]["metric"].string
        self.wdir = json["wdir"]["degrees"].string
        self.wx = json["wx"].string
        self.uvi = json["uvi"].string
        self.humiditi = json["humidity"].string
        self.feelsLike = json["feelslike"]["metric"].string
        self.snow = json["snow"]["metric"].string
        self.pop = json["pop"].string
        self.mslp = json["mslp"]["metric"].string
    }
    
}
