//
//  ViewControllerFactory.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 09/03/2023.
//

import Foundation
import UIKit

protocol ViewControllerFactoryProtocol {
    var weatherService: WeatherServiceProtocol { get }
    init(weatherService: WeatherServiceProtocol)
    func getCityWeatherViewController(navigationController: UINavigationController) -> CityWeatherListViewController
    func getWeatherForecastViewController(city: String) -> WeatherForecastViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    var weatherService: WeatherServiceProtocol
    required init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func getCityWeatherViewController(navigationController: UINavigationController) -> CityWeatherListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityWeatherListViewController") as! CityWeatherListViewController
        let viewModel = CityWeatherListViewModel(weatherService: weatherService)
        viewController.viewModel = viewModel
        let router = CityWeatherRouter(navigationController: navigationController, viewControllerFactory: self)
        viewController.router = router
        return viewController
    }

    func getWeatherForecastViewController(city: String) -> WeatherForecastViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        viewController.title = city
        let weatherService = weatherService
        let viewModel = WeatherForecastViewModel(weatherService: weatherService, city: city)
        viewController.viewModel = viewModel
        return viewController
    }
}
