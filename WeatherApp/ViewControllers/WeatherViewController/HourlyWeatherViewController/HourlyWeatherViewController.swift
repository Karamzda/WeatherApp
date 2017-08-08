//
//  HourlyWeaterViewController.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/2/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import RappleProgressHUD
import CoreLocation

class HourlyWeaterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var hourlyWeatherArray: [[HourlyWeather]?] = []
    var dateFormater: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "HourlyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyWeatherTableViewCell")
        self.dateFormater.dateFormat = "EEEE, MMM d, yyyy"
        
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationService.shared.delegate = self
        if LocationService.shared.currentLocation == nil {
            RappleActivityIndicatorView.startAnimatingWithLabel("Loading")
            LocationService.shared.requestLocation()
        } else {
            loadData()
            if hourlyWeatherArray.count == 0 {
                RappleActivityIndicatorView.startAnimatingWithLabel("Loading")
            }
        }
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let latitude = LocationService.shared.currentLocation?.coordinate.latitude
        let longitude = LocationService.shared.currentLocation?.coordinate.longitude
        
        WeatherManager.shared.getHourlyWeather(latitude: latitude!, longtitude: longitude!) { (hourlyWeather, error) in
            if error == nil {
                self.hourlyWeatherArray = hourlyWeather
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }


}

//MARK: UITableViewDelegate
extension HourlyWeaterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: UITableViewDataSource
extension HourlyWeaterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyWeatherArray[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherTableViewCell")! as! HourlyWeatherTableViewCell
        cell.setupCell(weather: (hourlyWeatherArray[indexPath.section]?[indexPath.row])!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.hourlyWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateFormater.string(from: (hourlyWeatherArray[section]?.first?.fccTime.date)!)
    }
}

//MARK: LocationServiceDelegate
extension HourlyWeaterViewController: LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        loadData()
    }
}
