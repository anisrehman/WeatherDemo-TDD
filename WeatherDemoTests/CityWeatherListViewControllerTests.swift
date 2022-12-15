//
//  CityWeatherListViewControllerTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 11/12/2022.
//

import XCTest
@testable import WeatherDemo

final class CityWeatherListViewControllerTests: XCTestCase {

    var viewController: CityWeatherListViewController!
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CityWeatherListViewController") as? CityWeatherListViewController
    }
    
    func test_CityWeatherListViewController_Returns_WeatherList() throws {

        let cityWeatherList = [
            CityWeather(city: "Multan", lat: 3, lon: 3, temp: 7, minTemp: 4, maxTemp: 44, iconURL: ""),
            CityWeather(city: "Lahore", lat: 4, lon: 4, temp: 7, minTemp: 2, maxTemp: 33,  iconURL: "")
        ]

        let weatherService = MockWeatherService(cityWeathers: cityWeatherList)
        viewController.viewModel = CityWeatherListViewModel(weatherService: weatherService)
        viewController.loadViewIfNeeded()

        XCTAssertNotNil(viewController.tableView)
        let dataSource = try XCTUnwrap(viewController.tableView.dataSource)

        let rowCount = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(cityWeatherList.count, rowCount)
        let cell = dataSource.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CityWeatherTableViewCell
        let tableViewCell = try XCTUnwrap(cell, "Cell nib not correct")

        XCTAssertEqual(tableViewCell.cityLabel.text, cityWeatherList[0].city)
        XCTAssertEqual(tableViewCell.tempLabel.text, "\(cityWeatherList[0].temp.formatted())°C")
        XCTAssertEqual(tableViewCell.maxTempLabel.text, "\(cityWeatherList[0].maxTemp.formatted())°C")
        XCTAssertEqual(tableViewCell.minTempLabel.text, "\(cityWeatherList[0].minTemp.formatted())°C")
    }

    func test_CityWeatherListViewController_Returns_Nil() throws {

        let weatherService = MockWeatherService(cityWeathers: nil)
        viewController.viewModel = CityWeatherListViewModel(weatherService: weatherService)
        viewController.loadViewIfNeeded()

        XCTAssertNotNil(viewController.tableView)
        let dataSource = try XCTUnwrap(viewController.tableView.dataSource)

        let rowCount = dataSource.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 0)
    }
}

class MockWeatherService: WeatherServiceProtocol {

    private var cityWeatherList: [CityWeather]?
    init(cityWeathers: [CityWeather]?) {
        cityWeatherList  = cityWeathers
    }

    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?) -> Void) {
        completion(cityWeatherList)
    }
}
