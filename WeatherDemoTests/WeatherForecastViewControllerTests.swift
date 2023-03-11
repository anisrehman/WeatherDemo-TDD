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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "WeatherForecastViewController") as! WeatherForecastViewController
        viewController.viewModel = WeatherForecastViewModel()
        
        viewController.loadViewIfNeeded()
        let dataSource = try! XCTUnwrap(viewController.tableView.dataSource)
        let viewModel = try! XCTAssertNotNil(viewController.viewModel)

        let count = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, 1)

        let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
}
