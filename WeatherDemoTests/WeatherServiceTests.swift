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
        let coord = WeatherResponse.Coord(lat: 30.1956, lon: 71.4753)
        let main = WeatherBaseResponse.Main(temp: 297.09, temp_min: 297.09, temp_max: 297.09)
        let weather = WeatherBaseResponse.Weather(id: 0, main: "", description: "", icon: "")
        let response = WeatherResponse(name: "Multan", cod: 200, coord: coord, main: main, weather: [weather], message: nil)
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true, response: response))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 1)
        let weather1 = cityWeatherList[0]
        XCTAssertEqual(weather1.city, "Multan")
    }

    func test_Fetch_City_Weather_Failed() async throws {
        let response = WeatherResponse(name: "Multan", cod: 200, coord: nil, main: nil, weather: nil, message: nil)
        let service = WeatherService(client: MockAPIClient(returnsSuccess: false, response: response))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 0)
    }

    func test_Fetch_City_Weather_Missing_Data() async throws {
        let response = WeatherResponse(name: "Multan", cod: 200, coord: nil, main: nil, weather: nil, message: nil)
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true, response: response))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 0)
    }

    func test_Get_City_Forecast_Success() async throws {
        let main = WeatherBaseResponse.Main(temp: 297.09, temp_min: 297.09, temp_max: 297.09)
        let weather = WeatherBaseResponse.Weather(id: 0, main: "", description: "", icon: "")
        let response = ForecastResponse(cod: "", list: [ForecastResponse.Forecast(dt: 0, dt_txt: "2023-04-12", main: main, weather: [weather])])
        let service = WeatherService(client: MockForecastAPIClient(returnsSuccess: true, response: response))
        let weatherForecastList = await service.getWeatherForecast(cityName: "Multan")
        XCTAssertEqual(weatherForecastList.count, 1)
        let forecast = weatherForecastList[0]
        XCTAssertEqual(forecast.date, "2023-04-12")
    }

    func test_Get_City_Forecast_Missing_Data() async throws {
        let response = ForecastResponse(cod: "", list: [])
        let service = WeatherService(client: MockForecastAPIClient(returnsSuccess: true, response: response))
        let cityWeatherList = await service.getWeatherForecast(cityName: "Multan")
        XCTAssertEqual(cityWeatherList.count, 0)
    }

    func test_Get_City_Forecast_Failed() async throws {
        let response = ForecastResponse(cod: "", list: [])
        let service = WeatherService(client: MockForecastAPIClient(returnsSuccess: false, response: response))
        let cityWeatherList = await service.getWeatherForecast(cityName: "Multan")
        XCTAssertEqual(cityWeatherList.count, 0)
    }
}

struct MockAPIClient: APIClientProtocol {
    let returnsSuccess: Bool
    let response: WeatherResponse

    init(returnsSuccess: Bool, response: WeatherResponse) {
        self.returnsSuccess = returnsSuccess
        self.response = response
    }

    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSessionProtocol) async throws -> T {
        if returnsSuccess {
            let weatherResponse = response
            return weatherResponse as! T
        }
        throw APIError(code: -1, message: "Parsing error")
    }
}

struct MockForecastAPIClient: APIClientProtocol {
    let returnsSuccess: Bool
    let response: ForecastResponse

    init(returnsSuccess: Bool, response: ForecastResponse) {
        self.returnsSuccess = returnsSuccess
        self.response = response
    }

    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSessionProtocol) async throws -> T {
        if returnsSuccess {
            let weatherResponse = response
            return weatherResponse as! T
        }
        throw APIError(code: -1, message: "Parsing error")
    }
}
