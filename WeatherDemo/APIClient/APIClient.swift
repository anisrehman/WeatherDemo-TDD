//
//  APIClient.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol APIErrorProtocol: Error {
    var code: Int { get }
    var message: String { get }
}

struct APIError: APIErrorProtocol {
    var code: Int
    var message: String
}

protocol APIClientProtocol {
    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSession, responseType: T.Type, completion: @escaping (T?, Error?) -> Void)
}

struct APIClient: APIClientProtocol {
    func sendRequest<T: Decodable>(_ request: URLRequest, with urlSession: URLSession, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            let urlResponse = response as! HTTPURLResponse
            switch urlResponse.statusCode {
            case 200:
                let result = try? JSONDecoder().decode(T.self, from: data!)
                if let result {
                    completion(result, nil)
                } else {
                    let error = APIError(code: -1, message: "JSON parsing error")
                    completion(nil, error)
                }

            default:
                let error = APIError(code: urlResponse.statusCode, message: "Not found")
                completion(nil, error)
            }
        }
        task.resume()
    }
}