//
//  CityWeatherListViewControllerTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 11/12/2022.
//

import XCTest
@testable import WeatherDemo

final class CityWeatherListViewControllerTests: XCTestCase {

    func testCityWeatherListViewController() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "CityWeatherListViewController") as? CityWeatherListViewController
        let vc = try XCTUnwrap(sut, "VC not connected to Storyboad")
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc.tableView)
        XCTAssertNotNil(vc.tableView.dataSource)
        XCTAssertNotNil(vc.tableView.delegate)

        let cityWeatherList = [
            CityWeather(city: "Multan", lat: 3, lon: 3, temp: 7, minTemp: 4, maxTemp: 44, iconURL: ""),
            CityWeather(city: "Lahore", lat: 4, lon: 4, temp: 7, minTemp: 2, maxTemp: 33,  iconURL: "")
        ]
        vc.cityWeatherList = cityWeatherList

        let rowCount = vc.tableView.dataSource?.tableView(vc.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(cityWeatherList.count, rowCount)
    }
}
