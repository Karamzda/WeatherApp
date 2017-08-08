//
//  WeatherSwipeViewController.swift
//  WeatherApp
//
//  Created by Taras Zinchenko on 8/2/17.
//  Copyright © 2017 Taras Zinchenko. All rights reserved.
//

import UIKit
import CarbonKit

class WeatherSwipeViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let items = ["Current", "Hourly", "10 day"] as [Any]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.setNormalColor(.black)
        carbonTabSwipeNavigation.setSelectedColor(.black)
        carbonTabSwipeNavigation.setIndicatorColor(.black)
        carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = UIColor(red: 86/255, green: 180/255, blue: 211/255, alpha: 1.0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 3, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 3, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 3, forSegmentAt: 2)
        carbonTabSwipeNavigation.setTabBarHeight(60)
        carbonTabSwipeNavigation.pagesScrollView?.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    


}

extension WeatherSwipeViewController: CarbonTabSwipeNavigationDelegate
{
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController
    {
        switch index
        {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrentWeatherViewController") as! CurrentWeatherViewController
            
            return vc
            
        case 1:
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourlyWeaterViewController") as! HourlyWeaterViewController
            
            return vc
            
        case 2:
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NextDaysViewController") as! NextDaysViewController
            
            return vc
            
        default:
            return UIViewController()
        }
    }
}
