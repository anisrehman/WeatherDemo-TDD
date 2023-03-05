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
        let window = UIWindow()
        let mainRouter = MainRouter(window: window)
        mainRouter.setupRootViewController()
        XCTAssertNotNil(mainRouter.window)
        XCTAssertNotNil(mainRouter.router)
        XCTAssertNotNil(mainRouter.viewModel)
        let navigationController = try! XCTUnwrap(mainRouter.navigationController)
        XCTAssertNotNil(navigationController.visibleViewController)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertNotNil(window.rootViewController)
    }
}
