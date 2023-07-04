//
//  CityWeatherListViewControllerTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 11/12/2022.
//

import XCTest
@testable import WeatherDemo

final class CityWeatherListViewControllerTests: XCTestCase {

    func test_CityWeatherListViewController_Returns_WeatherList() throws {

        let cityWeatherList = [
            CityWeather(city: "Multan", lat: 3, lon: 3, temp: 7, minTemp: 4, maxTemp: 44, iconURL: ""),
            CityWeather(city: "Lahore", lat: 4, lon: 4, temp: 7, minTemp: 2, maxTemp: 33,  iconURL: "")
        ]

        let weatherService = MockWeatherService(cityWeathers: cityWeatherList)
        let factory = ViewControllerFactory(weatherService: weatherService)
        let mainRouter = MainRouter(window: UIWindow(), factory: factory)
        mainRouter.setup()
        // We know WeatherForecastViewController is set to root
        let navigationController = try XCTUnwrap(mainRouter.navigationController)
        let viewControllers = navigationController.viewControllers
        XCTAssertGreaterThan(viewControllers.count, 0)
        let rootViewController = viewControllers[0] as? CityWeatherListViewController
        let viewController = try XCTUnwrap(rootViewController)
        viewController.loadViewIfNeeded()
        XCTAssertNotNil(viewController.tableView)
        let dataSource = try XCTUnwrap(viewController.tableView.dataSource)

        var expect = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //Wait for 2 seconds to complete loading
            let rowCount = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
            XCTAssertEqual(cityWeatherList.count, rowCount)
            let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CityWeatherTableViewCell
            let tableViewCell = try! XCTUnwrap(cell)

            XCTAssertEqual(tableViewCell.cityLabel.text, cityWeatherList[0].city)
            XCTAssertEqual(tableViewCell.tempLabel.text, "\(Int(cityWeatherList[0].temp))°")
            XCTAssertEqual(tableViewCell.maxTempLabel.text, "\(Int(cityWeatherList[0].maxTemp))°")
            XCTAssertEqual(tableViewCell.minTempLabel.text, "\(Int(cityWeatherList[0].minTemp))°")
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)

        // Select a cell.
        expect = expectation(description: "")
        let delegate = try XCTUnwrap(viewController.tableView.delegate)
        delegate.tableView?(viewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //Wait for 2 seconds to push view controller
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }

    func test_CityWeatherListViewController_Returns_Nil() throws {

        let weatherService = MockWeatherService(cityWeathers: nil)
        let factory = ViewControllerFactory(weatherService: weatherService)
        let viewController = factory.getCityWeatherViewController { _ in }
        viewController.loadViewIfNeeded()

        XCTAssertNotNil(viewController.tableView)
        let dataSource = try XCTUnwrap(viewController.tableView.dataSource)

        let rowCount = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 0)
    }
}

class MockWeatherService: WeatherServiceProtocol {
    func getWeatherForecast(cityName: String) async -> [WeatherDemo.WeatherForecast] {
        []
    }

    private var cityWeatherList: [CityWeather]?
    init(cityWeathers: [CityWeather]?) {
        cityWeatherList  = cityWeathers
    }

    func getWeather(cityNameList: [String]) async -> [CityWeather] {
        return cityWeatherList ?? []
    }
}
