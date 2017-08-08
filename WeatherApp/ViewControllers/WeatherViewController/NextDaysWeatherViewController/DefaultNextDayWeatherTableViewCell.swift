//
//  DefaultNextDayWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/4/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import Kingfisher

class DefaultNextDayWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(weather: NextDaysWeather) {
        self.dayLabel.text = "\(weather.day!)"
        self.mainImageView.kf.setImage(with: weather.icon)
        self.temperatureLabel.text = "\(weather.tempLow!)° | \(weather.tempHigh!)°"
        self.infoLabel.text = weather.condition
    }
    
}
