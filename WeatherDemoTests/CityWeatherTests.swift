//
//  CityWeatherTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 11/12/2022.
//

import XCTest
@testable import WeatherDemo

final class CityWeatherTests: XCTestCase {

    func testCityWeatherModel() throws {
        let cityWeather = CityWeather(city: "Multan", lat: 0.4, lon: 0.4, temp: 7, minTemp: 4, maxTemp: 44, iconURL: "")
        XCTAssertNotNil(cityWeather.city)
        XCTAssertNotEqual(cityWeather.city, "")
        XCTAssertLessThanOrEqual(cityWeather.minTemp, cityWeather.maxTemp)
        XCTAssertNotNil(cityWeather.iconURL)
    }
}
