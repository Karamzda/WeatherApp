//
//  LocationService.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/8/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation)
}

open class LocationService: NSObject {
    //MARK: VAR
    var delegate: LocationServiceDelegate?
    
    var currentLocation: CLLocation?
    
    //MARK: LET
    open static let shared = LocationService()
    
    fileprivate let locationManager = CLLocationManager()
    
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0
    }
    
    func requestLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

}


// MARK: - CLLocationManagerDelegate
extension LocationService : CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        if let location = locations.first {
            self.currentLocation = location
            delegate?.locationDidUpdate(self, location: location)
            
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
    }
}
