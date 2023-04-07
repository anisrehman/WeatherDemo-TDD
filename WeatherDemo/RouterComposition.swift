//
//  RouterComposition.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 09/03/2023.
//

import Foundation
import UIKit

protocol ViewControllerFactoryProtocol {
    var weatherService: WeatherServiceProtocol { get }
    init(weatherService: WeatherServiceProtocol)
    func getCityWeatherViewController(citySelected: @escaping ((String) -> Void)) -> CityWeatherListViewController
    func getWeatherForecastViewController() -> WeatherForecastViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    var weatherService: WeatherServiceProtocol
    required init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func getCityWeatherViewController(citySelected: @escaping ((String) -> Void)) -> CityWeatherListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityWeatherListViewController") as! CityWeatherListViewController
        let viewModel = CityWeatherListViewModel(weatherService: weatherService)
        viewController.viewModel = viewModel
        viewController.didSelectCity = citySelected
        return viewController
    }

    func getWeatherForecastViewController() -> WeatherForecastViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        let weatherService = weatherService
        let viewModel = WeatherForecastViewModel(weatherService: weatherService)
        viewController.viewModel = viewModel
        return viewController
    }
}
