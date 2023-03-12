//
//  File.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 12/03/2023.
//

import Foundation
@testable import WeatherDemo

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
