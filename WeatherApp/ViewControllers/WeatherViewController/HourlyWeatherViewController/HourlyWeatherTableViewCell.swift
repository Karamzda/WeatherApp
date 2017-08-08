//
//  HourlyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/2/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import Kingfisher

class HourlyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var icoinImageView: UIImageView!
    @IBOutlet weak var falloutLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(weather: HourlyWeather) {
        self.hourLabel.text = weather.fccTime.hour
        self.temperatureLabel.text = weather.temp
        self.icoinImageView.kf.setImage(with: weather.iconUrl)
        self.falloutLabel.text = weather.humiditi
    }
    
}
