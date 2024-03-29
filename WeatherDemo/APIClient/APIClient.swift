//
//  APIClient.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

struct APIError: LocalizedError {
    var code: Int
    var message: String

    public var errorDescription: String? {
        return message
    }
}

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

protocol APIClientProtocol {
    init(urlSession: URLSessionProtocol)
    func sendRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}

extension URLSession: URLSessionProtocol {

}

struct APIClient: APIClientProtocol {
    let urlSession: URLSessionProtocol
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
            let urlResponse = response as! HTTPURLResponse
            switch urlResponse.statusCode {
            case 200:
                let result = try? JSONDecoder().decode(T.self, from: data)
                if let result {
                    return result
                } else {
                    let error = APIError(code: -1, message: "JSON parsing error")
                    throw error
                }

            default:
                let error = APIError(code: urlResponse.statusCode, message: "Not found")
                throw error
            }
        } catch {
            debugPrint(error.localizedDescription)
            throw APIError(code: -1, message: error.localizedDescription)
        }
    }
}
