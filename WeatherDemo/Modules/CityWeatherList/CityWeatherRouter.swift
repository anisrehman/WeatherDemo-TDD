//
//  CityWeatherRouter.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 01/03/2023.
//

import Foundation
import UIKit

protocol CityWeatherRouting {
    var navigationController: UINavigationController { get }
    var routerComposition: RouterComposition { get }
    func showWeatherForecast()
}

class CityWeatherRouter: CityWeatherRouting {
    var navigationController: UINavigationController
    var routerComposition: RouterComposition
    init(navigationController: UINavigationController, routerComposition: RouterComposition) {
        self.navigationController = navigationController
        self.routerComposition = routerComposition
    }

    func showWeatherForecast() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        navigationController.pushViewController(viewController, animated: true)
    }
}
