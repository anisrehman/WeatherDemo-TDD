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
        let responseString = """
        {
            "coord": {
                "lon": 71.4753,
                "lat": 30.1956
            },
            "weather": [
                {
                    "id": 711,
                    "main": "Smoke",
                    "description": "smoke",
                    "icon": "50n"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 291.09,
                "feels_like": 290.82,
                "temp_min": 291.09,
                "temp_max": 291.09,
                "pressure": 1015,
                "humidity": 72
            },
            "visibility": 3500,
            "wind": {
                "speed": 0,
                "deg": 0
            },
            "clouds": {
                "all": 0
            },
            "dt": 1671288550,
            "sys": {
                "type": 1,
                "id": 7586,
                "country": "PK",
                "sunrise": 1671242637,
                "sunset": 1671279372
            },
            "timezone": 18000,
            "id": 1169825,
            "name": "Multan",
            "cod": 200
        }
        """

        let expectation = self.expectation(description: "API called")
        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: responseString)
        let client = APIClient()
        await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!), with: mockSession) { (response: WeatherResponse?, error: APIError?) in
            XCTAssertNil(error)
            let response = try! XCTUnwrap(response)
            let main = try! XCTUnwrap(response.main)
            XCTAssertNotNil(response.coord)
            XCTAssertEqual(response.name, "Multan")
            XCTAssertEqual(main.temp_max, 291.09)
            XCTAssertEqual(main.temp_min, 291.09)
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 5, handler: nil)
    }

    func test_APIClient_Returns_Error_Response() async {
        let responseString = """
        {
            "cod": 401,
            "message": "Invalid API key. Please see https://openweathermap.org/faq#error401 for more info."
        }
        """

        let expectation = self.expectation(description: "API called")
        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: responseString)
        let client = APIClient()
        await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!), with: mockSession) { (response: WeatherResponse?, error: APIError?) in
            let response = try! XCTUnwrap(response)
            XCTAssertEqual(response.cod, 401)
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 5, handler: nil)
    }

    func test_APIClient_Returns_Throw_Connection_Error() async {
        let responseString = ""
        let expectation = self.expectation(description: "API called")
        let mockSession = MockURLSession(throwError: true, statusCode: 200, responseString: responseString)
        let client = APIClient()
        await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!), with: mockSession) { (response: WeatherResponse?, error: APIError?) in
            XCTAssertNotNil(error)
            XCTAssertNil(response)
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 5, handler: nil)
    }

    func test_APIClient_Returns_Parsing_Error() async {
        let responseString = ""
        let expectation = self.expectation(description: "API called")
        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: responseString)
        let client = APIClient()
        await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!), with: mockSession) { (response: WeatherResponse?, error: APIError?) in
            XCTAssertNotNil(error)
            XCTAssertNil(response)
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 5, handler: nil)
    }

    func test_APIClient_Returns_NotFound_Error() async {
        let responseString = ""
        let expectation = self.expectation(description: "API called")
        let mockSession = MockURLSession(throwError: false, statusCode: 400, responseString: responseString)
        let client = APIClient()
        await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!), with: mockSession) { (response: WeatherResponse?, error: APIError?) in
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockURLSession: URLSessionProtocol {

    let throwError: Bool
    let statusCode: Int
    let responseString: String

    init(throwError: Bool, statusCode: Int, responseString: String) {
        self.throwError = throwError
        self.statusCode = statusCode
        self.responseString = responseString

    }

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if throwError {
            throw NSError(domain: "connection error", code: -1)
        }
        let data = responseString.data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: self.statusCode, httpVersion: nil, headerFields: nil)

        return (data!, response!)
    }
}
