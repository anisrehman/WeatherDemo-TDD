//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?, Error?) -> Void) async
}

class WeatherService: WeatherServiceProtocol {
    let apiClient: APIClientProtocol!
    init(client: APIClientProtocol) {
        self.apiClient = client
    }

    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?, Error?) -> Void) async {
        let parameters = [Constant.APIParameter.query: cityNameList[0], Constant.APIParameter.appID: Constant.apiKey]
        let urlComponents = URLComponents(string: Constant.getCityWeatherURL, parameters: parameters)
        let url = urlComponents.url!
        let request = URLRequest(url: url)
        await apiClient.sendRequest(request, with: URLSession.shared) { (weatherResponse: WeatherResponse?, error: APIError?) in
            guard let weatherResponse = weatherResponse else {
                completion(nil, error)
                return
            }

            guard let name = weatherResponse.name, let main = weatherResponse.main, let coord = weatherResponse.coord else {
                completion(nil, APIError(code: -1, message: "Missing weather data"))
                return
            }

            let cityWeather = CityWeather(city: name, lat: coord.lat, lon: coord.lon, temp: main.temp, minTemp: main.temp_min, maxTemp: main.temp_max, iconURL: "")
            completion([cityWeather], error)
        }
    }
}

//MARK: - Private Functions
extension URLComponents {
    init(string: String, parameters: [String: String]) {
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }

        self.init(string: string)!
        self.queryItems = queryItems
    }
}

struct WeatherResponse: Decodable {
    let name: String?
    let cod: Int
    let coord: Coord?
    let main: Main?
    let message: String?

    struct Coord: Decodable {
        let lat: Double
        let lon: Double
    }

    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
}




