//
//  WeatherServiceTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 15/12/2022.
//

import XCTest
@testable import WeatherDemo

final class WeatherServiceTests: XCTestCase {
        func test_Fetch_City_Weather_Success() async throws {
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: cityWeatherSuccessResponse)
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 1)
        let weather1 = cityWeatherList[0]
        XCTAssertEqual(weather1.city, "Multan")
    }

    func test_Fetch_City_Weather_Failed() async throws {
        let urlSession = MockURLSession(throwError: true, statusCode: 200, responseString: "")
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 0)
    }

    func test_Fetch_City_Weather_Invalid_City() async throws {
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: invalidCityWeatherResponse)
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 0)
    }
    
    func test_Get_City_Forecast_Group_By_Date_Success() async throws {
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: forecastSuccessResponse)
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let weatherForecastList = await service.getWeatherForcastGroupedByDate(cityName: "Multan")
        XCTAssertGreaterThanOrEqual(weatherForecastList.count, 1)
        let forecastGroup = weatherForecastList[0]
        XCTAssertEqual(forecastGroup.date, "2023-07-03")
        XCTAssertGreaterThan(forecastGroup.forecasts.count, 0)
    }

    func test_Get_City_Forecast_Missing_Data() async throws {
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: "")
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let forecastGroup = await service.getWeatherForcastGroupedByDate(cityName: "Multan")
        XCTAssertEqual(forecastGroup.count, 0)
    }

    func test_Get_City_Forecast_Failed() async throws {
        let urlSession = MockURLSession(throwError: true, statusCode: 200, responseString: "")
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let forecastGroup = await service.getWeatherForcastGroupedByDate(cityName: "Multan")
        XCTAssertEqual(forecastGroup.count, 0)
    }
}
