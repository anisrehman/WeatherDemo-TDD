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
        let forecasts = [
            ForecastResponse.Forecast(dt: 0, dt_txt: "2023-04-13", main: WeatherBaseResponse.Main(temp: 33, temp_min: 14, temp_max: 33), weather: [WeatherBaseResponse.Weather(id: 0, main: "", description: "", icon: "")]),
            ForecastResponse.Forecast(dt: 0, dt_txt: "2023-04-14", main: WeatherBaseResponse.Main(temp: 33, temp_min: 14, temp_max: 33), weather: [WeatherBaseResponse.Weather(id: 0, main: "", description: "", icon: "")]),
            ForecastResponse.Forecast(dt: 0, dt_txt: "2023-04-15", main: WeatherBaseResponse.Main(temp: 33, temp_min: 14, temp_max: 33), weather: [WeatherBaseResponse.Weather(id: 0, main: "", description: "", icon: "")]),
            ForecastResponse.Forecast(dt: 0, dt_txt: "2023-04-16", main: WeatherBaseResponse.Main(temp: 33, temp_min: 14, temp_max: 33), weather: [WeatherBaseResponse.Weather(id: 0, main: "", description: "", icon: "")])
        ]
        let response = ForecastResponse(cod: "", list: forecasts)
        let apiClient = MockForecastAPIClient(returnsSuccess: true, response: response)

        let client = MockForecastAPIClient(returnsSuccess: true, response: response)
        let viewController = ViewControllerFactory(weatherService: WeatherService(client: client)).getWeatherForecastViewController(city: "Multan")
        XCTAssertNotNil(viewController.viewModel)
        viewController.loadViewIfNeeded()
        let dataSource = try! XCTUnwrap(viewController.tableView.dataSource)
        let viewModel = try! XCTUnwrap(viewController.viewModel)

        var expect = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //Wait for 2 seconds to complete loading
            let count = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
            XCTAssertEqual(forecasts.count, count)
            let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
            XCTAssertNotNil(cell)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
}
