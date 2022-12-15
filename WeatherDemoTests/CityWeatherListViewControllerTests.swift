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

        let cityWeatherList = [
            CityWeather(city: "Multan", lat: 3, lon: 3, temp: 7, minTemp: 4, maxTemp: 44, iconURL: ""),
            CityWeather(city: "Lahore", lat: 4, lon: 4, temp: 7, minTemp: 2, maxTemp: 33,  iconURL: "")
        ]

        vc.viewModel = CityWeatherListViewModel(cityWeatherList: cityWeatherList)
        vc.loadViewIfNeeded()

        XCTAssertNotNil(vc.tableView)
        let dataSource = try XCTUnwrap(vc.tableView.dataSource)

        let rowCount = dataSource.tableView(vc.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(cityWeatherList.count, rowCount)
        let cell = dataSource.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CityWeatherTableViewCell
        let tableViewCell = try XCTUnwrap(cell, "Cell nib not correct")

        XCTAssertEqual(tableViewCell.cityLabel.text, cityWeatherList[0].city)
        XCTAssertEqual(tableViewCell.tempLabel.text, "\(cityWeatherList[0].temp.formatted())°C")
        XCTAssertEqual(tableViewCell.maxTempLabel.text, "\(cityWeatherList[0].maxTemp.formatted())°C")
        XCTAssertEqual(tableViewCell.minTempLabel.text, "\(cityWeatherList[0].minTemp.formatted())°C")
    }
}
