//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/2/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import CoreLocation
import RappleProgressHUD

class CurrentWeatherViewController: UIViewController, LocationServiceDelegate {

    //MARK: @IBOutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var humiditiLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LocationService.shared.delegate = self
        if LocationService.shared.currentLocation == nil {
            RappleActivityIndicatorView.startAnimatingWithLabel("Loading")
        }
        LocationService.shared.requestLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(isFirstLoad: Bool = false) {
        let latitude = LocationService.shared.currentLocation?.coordinate.latitude
        let longitude = LocationService.shared.currentLocation?.coordinate.longitude
        
        WeatherManager.shared.getCurrentWeather(latitude: latitude!, longitude: longitude!) { (currentWeather, error) in
            if error == nil {
                self.setup(weather: currentWeather)
                RappleActivityIndicatorView.stopAnimation()
            } else {
                
            }
        }
    }
    
    func setup(weather: CurrentDayWeather) {
        self.cityLabel.text = weather.fullLocation
        self.currentTemperatureLabel.text = "\(weather.temperature!)°"
        self.feelsLikeTemperatureLabel.text = "\(weather.feelsLike!)°"
        self.mainImageView.kf.setImage(with: weather.iconUrl)
        self.infoLabel.text = weather.weather
        self.humiditiLabel.text = weather.humidity
        self.windSpeedLabel.text = "\(weather.windSpeed!) km/h"
        self.windDirectionLabel.text = weather.windDirection
        self.dewPointLabel.text = "\(weather.dewPoint!)° "
        self.visibilityLabel.text = "\(weather.visibility!) km"
    }
    
    //MARK: LocationServiceDelegate
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        loadData()
    }
}

