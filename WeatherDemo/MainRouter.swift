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
    var factory: ViewControllerFactoryProtocol { get }
    var navigationController: UINavigationController? { get }
    func setup()
}

class MainRouter {
    var window: UIWindow
    var factory: ViewControllerFactoryProtocol
    var navigationController: UINavigationController

    init(window: UIWindow, factory: ViewControllerFactoryProtocol) {
        self.window = window
        self.factory = factory
        navigationController = UINavigationController()
    }

    func setup() {
        let viewController = factory.getCityWeatherViewController(navigationController: navigationController)
        navigationController.pushViewController(viewController, animated: false)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
