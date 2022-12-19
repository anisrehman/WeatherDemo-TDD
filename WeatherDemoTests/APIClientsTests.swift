//
//  APIClientsTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 17/12/2022.
//

import XCTest
@testable import WeatherDemo

final class APIClientsTests: XCTestCase {

    func test_APIClient_Returns_Response() {
        let mockSession = MockURLSession()
        let client = APIClient()
        client.sendRequest(URLRequest(url: URL(string: "https://google.com")!), with: mockSession, responseType: WeatherResponse.self) { response, error in

        }
    }
}
class MockURLSession: URLSession {
    override init() {

    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler)
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
    }

    override func resume() {
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
        let data = responseString.data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        completionHandler(data, response, nil)
    }
}
