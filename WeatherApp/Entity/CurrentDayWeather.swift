//
//  CurrentDayWeather.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/8/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class CurrentDayWeather {
    
    let fullLocation: String!
    let weather: String!
    let temperature: Int!
    let humidity: String!
    let windDirection: String!
    let windSpeed: Int!
    let dewPoint: Int!
    let feelsLike: String!
    let visibility: String!
    let iconUrl: URL!
    
    required init(json: JSON) {
        self.fullLocation = json["display_location"]["full"].string
        self.weather = json["weather"].string
        self.temperature = json["temp_c"].int
        self.humidity = json["relative_humidity"].string
        self.windDirection = json["wind_dir"].string
        self.windSpeed = json["wind_kph"].int
        self.dewPoint = json["dewpoint_c"].int
        self.feelsLike = json["feelslike_c"].string
        self.visibility = json["visibility_km"].string
        self.iconUrl = json["icon_url"].url
    }

}
