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
        let composition = RouterComposition()
        let window = UIWindow()
        let mainRouter = MainRouter(window: window, routerComposition: composition)
        mainRouter.setup()
        XCTAssertNotNil(mainRouter.window)
        XCTAssertNotNil(window.rootViewController)
    }
}

