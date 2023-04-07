//
//  MainRouterTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 22/02/2023.
//

import XCTest
@testable import WeatherDemo

final class MainRouterTests: XCTestCase {

    func testMainRouter() {
        let factory = ViewControllerFactory(weatherService: WeatherService(client: APIClient()))
        let window = UIWindow()
        let mainRouter = MainRouter(window: window, factory: factory)
        mainRouter.setup()
        XCTAssertNotNil(mainRouter.window)
        XCTAssertNotNil(window.rootViewController)
    }
}

