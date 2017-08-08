//
//  NextDaysViewController.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/2/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import RappleProgressHUD
import CoreLocation

class NextDaysViewController: UIViewController {
    
    //MARK: VAR
    var nextDaysWeatherArray: [NextDaysWeather] = []
    var date: Date!
    var dateFormater: DateFormatter = DateFormatter()
    
    var nineDaysfromNow: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 9, to: Date(), options: [])!
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.date  = NSDate() as Date
        self.dateFormater.dateFormat = "EEEE, MMM d"
        
        self.tableView.register(UINib(nibName: "DefaultNextDayWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultNextDayWeatherTableViewCell")

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LocationService.shared.delegate = self
        if LocationService.shared.currentLocation == nil {
            RappleActivityIndicatorView.startAnimatingWithLabel("Loading")
            LocationService.shared.requestLocation()
        } else {
            loadData()
            if nextDaysWeatherArray.count == 0 {
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
        
        WeatherManager.shared.getNextDaysWeather(latitude: latitude!, longitude: longitude!) { (nextDaysWeather, error) in
            if error == nil {
                self.nextDaysWeatherArray = nextDaysWeather
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    
    func fromDateToDateString(date1: NSDate, date2: NSDate) -> String {
        return "\(dateFormater.string(from: date1 as Date)) - \(dateFormater.string(from: date2 as Date))"
    }

}

//MARK: UITableViewDelegate
extension NextDaysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: UITableViewDataSource
extension NextDaysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nextDaysWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultNextDayWeatherTableViewCell")! as! DefaultNextDayWeatherTableViewCell
        cell.setupCell(weather: nextDaysWeatherArray[indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fromDateToDateString(date1: date! as NSDate, date2: nineDaysfromNow as NSDate)
    }
}

//MARK: LocationServiceDelegate
extension NextDaysViewController: LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        loadData()
    }
}

