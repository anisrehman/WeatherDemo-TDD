//
//  APIClientsTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 17/12/2022.
//

import XCTest
@testable import WeatherDemo

final class APIClientsTests: XCTestCase {
    let forecastResponse = """
    {
      "cod": "200",
      "message": 0,
      "cnt": 40,
      "list": [
        {
          "dt": 1678600800,
          "main": {
            "temp": 299.05,
            "feels_like": 298.98,
            "temp_min": 299.05,
            "temp_max": 304.98,
            "pressure": 1015,
            "sea_level": 1015,
            "grnd_level": 1000,
            "humidity": 49,
            "temp_kf": -5.93
          },
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04d"
            }
          ],
          "clouds": {
            "all": 60
          },
          "wind": {
            "speed": 2.31,
            "deg": 299,
            "gust": 2.32
          },
          "visibility": 10000,
          "pop": 0,
          "sys": {
            "pod": "d"
          },
          "dt_txt": "2023-03-12 06:00:00"
        },
        {
          "dt": 1678611600,
          "main": {
            "temp": 304.07,
            "feels_like": 302.8,
            "temp_min": 304.07,
            "temp_max": 308.06,
            "pressure": 1013,
            "sea_level": 1013,
            "grnd_level": 997,
            "humidity": 30,
            "temp_kf": -3.99
          },
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04d"
            }
          ],
          "clouds": {
            "all": 80
          },
          "wind": {
            "speed": 3.28,
            "deg": 298,
            "gust": 3.77
          },
          "visibility": 10000,
          "pop": 0,
          "sys": {
            "pod": "d"
          },
          "dt_txt": "2023-03-12 09:00:00"
        },
        {
          "dt": 1678622400,
          "main": {
            "temp": 306.25,
            "feels_like": 303.87,
            "temp_min": 306.25,
            "temp_max": 306.25,
            "pressure": 1011,
            "sea_level": 1011,
            "grnd_level": 996,
            "humidity": 13,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "clouds": {
            "all": 100
          },
          "wind": {
            "speed": 4.05,
            "deg": 338,
            "gust": 3.83
          },
          "visibility": 10000,
          "pop": 0,
          "sys": {
            "pod": "d"
          },
          "dt_txt": "2023-03-12 12:00:00"
        },
        {
          "dt": 1678633200,
          "main": {
            "temp": 300.78,
            "feels_like": 299.62,
            "temp_min": 300.78,
            "temp_max": 300.78,
            "pressure": 1012,
            "sea_level": 1012,
            "grnd_level": 997,
            "humidity": 19,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {
            "all": 100
          },
          "wind": {
            "speed": 2.13,
            "deg": 19,
            "gust": 2.21
          },
          "visibility": 10000,
          "pop": 0,
          "sys": {
            "pod": "n"
          },
          "dt_txt": "2023-03-12 15:00:00"
        }
      ],
      "city": {
        "id": 1169825,
        "name": "Multan",
        "coord": {
          "lat": 30.1956,
          "lon": 71.4753
        },
        "country": "PK",
        "population": 1437230,
        "timezone": 18000,
        "sunrise": 1678584508,
        "sunset": 1678627186
      }
    }
    """
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

        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: responseString)
        let client = APIClient(urlSession: mockSession)
        let response: WeatherResponse? = try? await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!))
        let main = try! XCTUnwrap(response?.main)
        let weather = try! XCTUnwrap(response?.weather)
        XCTAssertNotNil(response?.coord)
        XCTAssertEqual(response?.name, "Multan")
        XCTAssertEqual(main.temp_max, 291.09)
        XCTAssertEqual(main.temp_min, 291.09)
        XCTAssertEqual(weather.count, 1)
        XCTAssertEqual(weather[0].icon, "50n")
    }

    func test_CityWeatherAPI_Returns_Error_Response() async {
        let responseString = """
        {
            "cod": 401,
            "message": "Invalid API key. Please see https://openweathermap.org/faq#error401 for more info."
        }
        """

        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: responseString)
        let client = APIClient(urlSession: mockSession)

        let weatherResponse: WeatherResponse? = try? await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!))
        let response = try! XCTUnwrap(weatherResponse)
        XCTAssertEqual(response.cod, 401)
    }

    func test_APIClient_Returns_Throw_Connection_Error() async {
        let responseString = ""
        let mockSession = MockURLSession(throwError: true, statusCode: 200, responseString: responseString)
        let client = APIClient(urlSession: mockSession)

        do {
            let _: WeatherResponse? = try await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!))
        } catch let error {
            let error = error as? APIError
            XCTAssertNotNil(error)
            let e = try! XCTUnwrap(error)
            XCTAssertEqual(e.localizedDescription, e.message)
        }
    }

    func test_CityWeatherAPI_Returns_Parsing_Error() async {
        let responseString = ""
        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: responseString)
        let client = APIClient(urlSession: mockSession)
        do {
            let _: WeatherResponse? = try await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!))
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func test_CityWeatherAPI_Returns_NotFound_Error() async {
        let responseString = ""
        let mockSession = MockURLSession(throwError: false, statusCode: 400, responseString: responseString)
        let client = APIClient(urlSession: mockSession)
        do {
            let _: WeatherResponse? = try await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!))
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func test_WeatherForecastAPI_Returns_Success_Response() async {
        let mockSession = MockURLSession(throwError: false, statusCode: 200, responseString: forecastResponse)
        let client = APIClient(urlSession: mockSession)
        let response: ForecastResponse? = try? await client.sendRequest(URLRequest(url: URL(string: "https://google.com")!))
        let forecastList = try! XCTUnwrap(response?.list)
        XCTAssertNotNil(response?.cod)
        XCTAssertGreaterThan(forecastList.count, 0)
        let forecast = forecastList[0]
        let weatherList = try! XCTUnwrap(forecast.weather)
        XCTAssertGreaterThan(weatherList.count, 0)
    }
}
