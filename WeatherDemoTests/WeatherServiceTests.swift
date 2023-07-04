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

    func test_Get_City_Forecast_Success() async throws {
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: forecastSuccessResponse)
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let weatherForecastList = await service.getWeatherForecast(cityName: "Multan")
        XCTAssertGreaterThanOrEqual(weatherForecastList.count, 1)
        let forecast = weatherForecastList[0]
        XCTAssertEqual(forecast.date, "2023-07-03 09:00:00")
    }

    func test_Get_City_Forecast_Missing_Data() async throws {
        let urlSession = MockURLSession(throwError: false, statusCode: 200, responseString: "")
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let cityWeatherList = await service.getWeatherForecast(cityName: "Multan")
        XCTAssertEqual(cityWeatherList.count, 0)
    }

    func test_Get_City_Forecast_Failed() async throws {
        let urlSession = MockURLSession(throwError: true, statusCode: 200, responseString: "")
        let service = WeatherService(client: APIClient(urlSession: urlSession))
        let cityWeatherList = await service.getWeatherForecast(cityName: "Multan")
        XCTAssertEqual(cityWeatherList.count, 0)
    }
}
