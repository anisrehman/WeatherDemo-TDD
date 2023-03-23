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

    }

    func testWeatherForecastViewController() {
        let viewController = MockedRouterComposition().getWeatherForecastViewController()
        XCTAssertNotNil(viewController.viewModel)
        viewController.loadViewIfNeeded()
        let dataSource = try! XCTUnwrap(viewController.tableView.dataSource)
        let viewModel = try! XCTAssertNotNil(viewController.viewModel)

        let count = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, 1)

        let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
}

class MockedRouterComposition: WeatherForecastRouterComposing {
    func getWeatherForecastViewController() -> WeatherForecastViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        let weatherService = WeatherService(client: APIClient())
        let viewModel = WeatherForecastViewModel()
        viewController.viewModel = viewModel
        return viewController
    }

    
}
