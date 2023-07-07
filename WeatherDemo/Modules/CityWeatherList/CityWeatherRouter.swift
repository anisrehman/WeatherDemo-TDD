//
//  CityWeatherRouter.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 01/03/2023.
//

import Foundation
import UIKit

protocol CityWeatherRouting {
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory)
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllerFactory { get }
    func showWeatherForecast(city: String)
}

class CityWeatherRouter: CityWeatherRouting {
    var navigationController: UINavigationController
    var viewControllerFactory: ViewControllerFactory
    required init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    func showWeatherForecast(city: String) {
        let viewController = viewControllerFactory.getWeatherForecastViewController(city: city)
        navigationController.pushViewController(viewController, animated: true)
    }
}
