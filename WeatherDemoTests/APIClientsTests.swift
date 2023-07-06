//
//  APIClientsTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 17/12/2022.
//

import XCTest
@testable import WeatherDemo

final class APIClientsTests: XCTestCase {
    func test_APIClient_Returns_Success_Response() async {
        let mockSession = MockURLSession(cityWeatherResponse: .success)
        let client = APIClient(urlSession: mockSession)
        let response: WeatherResponse? = try? await client.sendRequest(URLRequest(url: URL(string: Constant.cityWeatherURL)!))
        let main = try! XCTUnwrap(response?.main)
        let weather = try! XCTUnwrap(response?.weather)
        XCTAssertNotNil(response?.coord)
        XCTAssertEqual(response?.name, "Multan")
        XCTAssertEqual(main.temp_max, 312.09)
        XCTAssertEqual(main.temp_min, 312.09)
        XCTAssertEqual(weather.count, 1)
        XCTAssertEqual(weather[0].icon, "50d")
    }

    func test_CityWeatherAPI_Returns_Error_Response() async {
        let mockSession = MockURLSession(cityWeatherResponse: .invalidCity)
        let client = APIClient(urlSession: mockSession)

        let weatherResponse: WeatherResponse? = try? await client.sendRequest(URLRequest(url: URL(string: Constant.cityWeatherURL)!))
        let response = try! XCTUnwrap(weatherResponse)
        XCTAssertEqual(response.cod, 404)
    }

    func test_APIClient_Returns_Throw_Connection_Error() async {
        let mockSession = MockURLSession(cityWeatherResponse: .fail)
        let client = APIClient(urlSession: mockSession)

        do {
            let _: WeatherResponse? = try await client.sendRequest(URLRequest(url: URL(string: Constant.cityWeatherURL)!))
        } catch let error {
            let error = error as? APIError
            XCTAssertNotNil(error)
            let e = try! XCTUnwrap(error)
            XCTAssertEqual(e.localizedDescription, e.message)
        }
    }

    func test_CityWeatherAPI_Returns_Parsing_Error() async {
        let mockSession = MockURLSession(cityWeatherResponse: .successMissingData)
        let client = APIClient(urlSession: mockSession)
        do {
            let _: WeatherResponse? = try await client.sendRequest(URLRequest(url: URL(string: Constant.cityWeatherURL)!))
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func test_CityWeatherAPI_Returns_NotFound_Error() async {
        let mockSession = MockURLSession(statusCode: 404)
        let client = APIClient(urlSession: mockSession)
        do {
            let _: WeatherResponse? = try await client.sendRequest(URLRequest(url: URL(string: Constant.cityWeatherURL)!))
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
