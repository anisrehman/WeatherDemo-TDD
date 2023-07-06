//
//  File.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 12/03/2023.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    let cityWeatherResponse: MockCityWeatherResponse
    let forecastResponse: MockForecastResponse
    let statusCode: Int

    init(cityWeatherResponse: MockCityWeatherResponse = .success, forecastResponse: MockForecastResponse = .success, statusCode: Int = 200) {
        self.cityWeatherResponse = cityWeatherResponse
        self.forecastResponse = forecastResponse
        self.statusCode = statusCode
    }

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        let urlString = request.url!.absoluteString
        let city = request.url?.queryParameters?["q"] ?? ""
        var responseString = ""
        if urlString.starts(with: Constant.cityWeatherURL) {
            responseString = try cityWeatherResponse.getResponse(city: city)
        } else if urlString.starts(with: Constant.forecastURL) {
            responseString = try forecastResponse.getResponse()
        } else {
            throw NSError(domain: "connection error", code: -1)
        }            
        
        let data = responseString.data(using: .utf8)
        let response = HTTPURLResponse(url: request.url!, statusCode: self.statusCode, httpVersion: nil, headerFields: nil)

        return (data!, response!)
    }
}

enum MockCityWeatherResponse {
    case success
    case successMissingData
    case invalidCity
    case fail
    
    func getResponse(city: String) throws -> String {
        switch self {
        case .success:
            return cityWeatherSuccessResponse(for: city)
        case .successMissingData:
            return ""
        case .invalidCity:
            return invalidCityWeatherResponse
        case .fail:
            throw NSError(domain: "connection error", code: -1)
        }
    }
}

enum MockForecastResponse {
    case success
    case successMissingData
    case fail
    
    func getResponse() throws -> String {
        switch self {
        case .success:
            return forecastSuccessResponse
        case .successMissingData:
            return ""
        case .fail:
            throw NSError(domain: "connection error", code: -1)
        }
    }
}
