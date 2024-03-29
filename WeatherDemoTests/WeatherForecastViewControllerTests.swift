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
        // Setup mock response
        let urlSession = MockURLSession(cityWeatherResponse: .success, statusCode: 200)
        let client = APIClient(urlSession: urlSession)
        let viewController = ViewControllerFactory(weatherService: WeatherService(client: client)).getWeatherForecastViewController(city: "Multan")
        XCTAssertNotNil(viewController.viewModel)
        viewController.loadViewIfNeeded()
        let dataSource = try! XCTUnwrap(viewController.tableView.dataSource)
        let viewModel = try! XCTUnwrap(viewController.viewModel)

        var expect = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //Wait for 2 seconds to complete loading
            let sections = dataSource.numberOfSections!(in: viewController.tableView)
            XCTAssertEqual(sections, 5)
            var count = dataSource .tableView(viewController.tableView, numberOfRowsInSection: 0)
            XCTAssertEqual(count, 5)
            count = dataSource .tableView(viewController.tableView, numberOfRowsInSection: 1)
            XCTAssertEqual(count, 7)
            let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
            XCTAssertNotNil(cell)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
}
