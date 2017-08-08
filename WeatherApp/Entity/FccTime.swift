//
//  FccTime.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/3/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import SwiftyJSON

class FccTime {
    
    let hour: String!
    let year: String!
    let mon: String!
    let mday: String!
    let epoch: String!
    var date: Date!
    
    required init(json: JSON) {
        hour = json["hour"].string
        year = json["year"].string
        mon = json["mon"].string
        mday = json["mday"].string
        epoch = json["epoch"].string
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        date = dateFormatter.date(from: "\(year!)-\(mon!)-\(mday!)")
    }
}

extension Date {
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: date).day ?? 0
    }
}
