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
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: forecastSuccessResponse)
        let client = APIClient(urlSession: urlSession)
        let viewController = ViewControllerFactory(weatherService: WeatherService(client: client)).getWeatherForecastViewController(city: "Multan")
        XCTAssertNotNil(viewController.viewModel)
        viewController.loadViewIfNeeded()
        let dataSource = try! XCTUnwrap(viewController.tableView.dataSource)
        let viewModel = try! XCTUnwrap(viewController.viewModel)

        var expect = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //Wait for 2 seconds to complete loading
            let count = dataSource .tableView(viewController.tableView, numberOfRowsInSection: 0)
            XCTAssertEqual(count, 40)
            let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
            XCTAssertNotNil(cell)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
}
