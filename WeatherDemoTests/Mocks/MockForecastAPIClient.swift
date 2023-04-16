//
//  MockForecastAPIClient.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 13/04/2023.
//

import Foundation
@testable import WeatherDemo

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
