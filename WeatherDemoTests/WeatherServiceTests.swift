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
        let expectation = self.expectation(description: "Weather Fetched")
        let coord = WeatherResponse.Coord(lat: 30.1956, lon: 71.4753)
        let main = WeatherResponse.Main(temp: 297.09, temp_min: 297.09, temp_max: 297.09)
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true, main: main, coord: coord))
        var weather: CityWeather?
        try? await service.getWeather(cityNameList: ["Multan"]) { cityWeatherList in
            if let cityWeatherList, cityWeatherList.count > 0 {
                weather = cityWeatherList[0]
            }
            expectation.fulfill()

        }
        await waitForExpectations(timeout: 5, handler: nil)
        let weather2 = try XCTUnwrap(weather)
        XCTAssertEqual(weather2.city, "Multan")
    }

    func test_Fetch_Weather_Failed() async throws {
        let service = WeatherService(client: MockAPIClient(returnsSuccess: false, main: nil, coord: nil))
        do {
            try await service.getWeather(cityNameList: ["Multan"]) { cityWeatherList in
            }
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func test_Fetch_Weather_Missing_Data() async throws {
        let expectation = self.expectation(description: "Weather Fetched")
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true, main: nil, coord: nil))
        var weatherList: [CityWeather]?
        try? await service.getWeather(cityNameList: ["Multan"]) { cityWeatherList in
            weatherList = cityWeatherList
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(weatherList)
    }
}


struct MockAPIClient: APIClientProtocol {
    let returnsSuccess: Bool
    let main: WeatherResponse.Main?
    let coord: WeatherResponse.Coord?
    init(returnsSuccess: Bool, main: WeatherResponse.Main?, coord: WeatherResponse.Coord?) {
        self.returnsSuccess = returnsSuccess
        self.main = main
        self.coord = coord
    }

    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSessionProtocol) async throws -> T {
        if returnsSuccess {
            let weatherResponse = WeatherResponse(name: "Multan", cod: 200, coord: coord, main: main, message: nil)
            return weatherResponse as! T
        } else {
            throw APIError(code: -1, message: "Parsing error")
        }
    }
}
