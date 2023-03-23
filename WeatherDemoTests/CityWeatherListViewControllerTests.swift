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
        viewController.router = CityWeatherRouter(navigationController: UINavigationController(), routerComposition: WeatherForecastRouterComposition())
        viewController.loadViewIfNeeded()
        XCTAssertNotNil(viewController.tableView)
        let dataSource = try XCTUnwrap(viewController.tableView.dataSource)

        let expect = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
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
        wait(for: [expect], timeout: 12)

        // Open forecast screen.
        let vcCount = viewController.router.navigationController.viewControllers.count
        let delegate = try XCTUnwrap(viewController.tableView.delegate)
        delegate.tableView?(viewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(viewController.router.navigationController)
        //VC count has been increased
        XCTAssertEqual(viewController.router.navigationController.viewControllers.count, vcCount + 1)
        XCTAssertNotNil(viewController.router)

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

    func getWeather(cityNameList: [String]) async -> [CityWeather] {
        return cityWeatherList ?? []
    }
}
