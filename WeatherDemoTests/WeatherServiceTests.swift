//
//  WeatherServiceTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 15/12/2022.
//

import XCTest
@testable import WeatherDemo

final class WeatherServiceTests: XCTestCase {

    func test_Fetch_Weather_Success() async throws {
        let coord = WeatherResponse.Coord(lat: 30.1956, lon: 71.4753)
        let main = WeatherResponse.Main(temp: 297.09, temp_min: 297.09, temp_max: 297.09)
        let weather = WeatherResponse.Weather(id: 0, main: "", description: "", icon: "")
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true, main: main, coord: coord, weather: [weather]))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 1)
        let weather1 = cityWeatherList[0]
        XCTAssertEqual(weather1.city, "Multan")
    }

    func test_Fetch_Weather_Failed() async throws {
        let service = WeatherService(client: MockAPIClient(returnsSuccess: false, main: nil, coord: nil, weather: nil))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 0)
    }

    func test_Fetch_Weather_Missing_Data() async throws {
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true, main: nil, coord: nil, weather: nil))
        let cityWeatherList = await service.getWeather(cityNameList: ["Multan"])
        XCTAssertEqual(cityWeatherList.count, 0)
    }
}


struct MockAPIClient: APIClientProtocol {
    let returnsSuccess: Bool
    let main: WeatherResponse.Main?
    let coord: WeatherResponse.Coord?
    let weather: [WeatherResponse.Weather]?

    init(returnsSuccess: Bool, main: WeatherResponse.Main?, coord: WeatherResponse.Coord?, weather:  [WeatherResponse.Weather]?) {
        self.returnsSuccess = returnsSuccess
        self.main = main
        self.coord = coord
        self.weather = weather
    }

    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSessionProtocol) async throws -> T {
        if returnsSuccess {
            let weatherResponse = WeatherResponse(name: "Multan", cod: 200, coord: coord, main: main, weather: weather, message: nil)
            return weatherResponse as! T
        }
        throw APIError(code: -1, message: "Parsing error")
    }
}
