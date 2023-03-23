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
    var routerComposition: CityWeatherListRouterComposing { get }
    func setup()
}

class MainRouter {
    var window: UIWindow
    var routerComposition: CityWeatherListRouterComposing

    init(window: UIWindow, routerComposition: CityWeatherListRouterComposing) {
        self.window = window
        self.routerComposition = routerComposition
    }

    func setup() {
        let navigationController = UINavigationController()
        let viewController = routerComposition.getCityWeatherViewController(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: false)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}