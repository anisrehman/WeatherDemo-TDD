//
//  MainRouter.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 21/02/2023.
//

import Foundation
import UIKit

protocol MainRouting {
    var window: UIWindow { get }
    var navigationController: UINavigationController? { get }
    var viewModel: CityWeatherListViewModel? { get }
    var router: CityWeatherRouting? { get }
    func setupRootViewController()
}

class MainRouter {
    var window: UIWindow
    var navigationController: UINavigationController?
    var viewModel: CityWeatherListViewModel?
    var router: CityWeatherRouting?

    init(window: UIWindow) {
        self.window = window
    }

    func setupRootViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityWeatherListViewController") as? CityWeatherListViewController
        navigationController = UINavigationController(rootViewController: viewController!)
        let weatherService = WeatherService(client: APIClient())
        self.viewModel = CityWeatherListViewModel(weatherService: weatherService)
        viewController?.viewModel = self.viewModel
        self.router = CityWeatherRouter(navigationController: navigationController!)
        viewController?.router = self.router
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
