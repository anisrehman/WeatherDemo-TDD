//
//  RouterComposition.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 09/03/2023.
//

import Foundation
import UIKit

protocol CityWeatherListRouterComposing {
    func getCityWeatherViewController(navigationController: UINavigationController) -> CityWeatherListViewController
}

protocol WeatherForecastRouterComposing {
    func getWeatherForecastViewController() -> WeatherForecastViewController
}

class CityWeatherListRouterComposition: CityWeatherListRouterComposing {
    func getCityWeatherViewController(navigationController: UINavigationController) -> CityWeatherListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityWeatherListViewController") as! CityWeatherListViewController
        let weatherService = WeatherService(client: APIClient())
        let viewModel = CityWeatherListViewModel(weatherService: weatherService)
        viewController.viewModel = viewModel
        viewController.router = CityWeatherRouter(navigationController: navigationController, routerComposition: WeatherForecastRouterComposition())
        return viewController
    }
}

class WeatherForecastRouterComposition: WeatherForecastRouterComposing {
    func getWeatherForecastViewController() -> WeatherForecastViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        let weatherService = WeatherService(client: APIClient())
        let viewModel = WeatherForecastViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
