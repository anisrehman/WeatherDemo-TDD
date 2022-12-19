//
//  WeatherServiceTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 15/12/2022.
//

import XCTest
@testable import WeatherDemo

final class WeatherServiceTests: XCTestCase {

    func test_Fetch_Weather_Success() throws {
        let expectation = self.expectation(description: "Weather Fetched")
        let service = WeatherService(client: MockAPIClient(returnsSuccess: true))
        var weather: CityWeather?
        service.getWeather(cityNameList: ["Multan"]) { cityWeatherList, error in
            if let cityWeatherList, cityWeatherList.count > 0 {
                weather = cityWeatherList[0]
            }
            expectation.fulfill()

        }
        waitForExpectations(timeout: 5, handler: nil)
        let weather2 = try XCTUnwrap(weather, "Weather is nil")
        XCTAssertEqual(weather2.city, "Multan")
    }

    func test_Fetch_Weather_Failed() throws {
        let expectation = self.expectation(description: "Weather Fetched")
        let service = WeatherService(client: MockAPIClient(returnsSuccess: false))
        var weatherList: [CityWeather]?
        service.getWeather(cityNameList: ["Multan"]) { cityWeatherList, error in
            weatherList = cityWeatherList
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(weatherList)
    }
}


struct MockAPIClient: APIClientProtocol {
    var returnsSuccess = true
    init(returnsSuccess: Bool) {
        self.returnsSuccess = returnsSuccess
    }

    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSession, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        if returnsSuccess {
            let coord = WeatherResponse.Coord(lat: 30.1956, lon: 71.4753)
            let main = WeatherResponse.Main(temp: 297.09, temp_min: 297.09, temp_max: 297.09)
            let weatherResponse = WeatherResponse(name: "Multan", cod: 200, coord: coord, main: main)

            completion(weatherResponse as? T, nil)
        } else {
            completion(nil, APIError(code: -1, message: "Parsing error"))
        }
    }
}


