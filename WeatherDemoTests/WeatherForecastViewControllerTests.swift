//
//  WeatherForecastViewControllerTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 21/02/2023.
//

import XCTest
@testable import WeatherDemo

final class WeatherForecastViewControllerTests: XCTestCase {
    var viewController: WeatherForecastViewController!
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as? WeatherForecastViewController
    }

    func testWeatherForecastViewController() {
        viewController.loadViewIfNeeded()
        XCTAssertNotNil(viewController.view)
    }
}
