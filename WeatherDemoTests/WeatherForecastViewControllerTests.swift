//
//  WeatherForecastViewControllerTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 21/02/2023.
//

import XCTest
@testable import WeatherDemo

final class WeatherForecastViewControllerTests: XCTestCase {

    func testWeatherForecastViewController() {
        let viewController = ViewControllerFactory(weatherService: WeatherService(client: APIClient())).getWeatherForecastViewController()
        XCTAssertNotNil(viewController.viewModel)
        viewController.loadViewIfNeeded()
        let dataSource = try! XCTUnwrap(viewController.tableView.dataSource)
        let viewModel = try! XCTUnwrap(viewController.viewModel)

        let count = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, 1)

        let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
}
