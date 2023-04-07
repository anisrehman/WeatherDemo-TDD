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
    var navigationController: UINavigationController?

    init(window: UIWindow, factory: ViewControllerFactoryProtocol) {
        self.window = window
        self.factory = factory
    }

    func setup() {
        navigationController = UINavigationController()
        let viewController = factory.getCityWeatherViewController { [weak self] city in
            let viewController = self?.factory.getWeatherForecastViewController()
            self?.navigationController?.pushViewController(viewController!, animated: true)
        }
        navigationController?.pushViewController(viewController, animated: false)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
