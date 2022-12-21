//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?, Error?) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    let apiClient: APIClientProtocol!
    init(client: APIClientProtocol) {
        self.apiClient = client
    }

    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?, Error?) -> Void) {
        let parameters = [Constant.APIParameter.query: cityNameList[0], Constant.APIParameter.appID: Constant.apiKey]
        let urlComponents = URLComponents(string: Constant.getCityWeatherURL, parameters: parameters)
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        apiClient.sendRequest(request, with: URLSession.shared, responseType: WeatherResponse.self) { weatherResponse, error in
            guard let weatherResponse = weatherResponse else {
                completion(nil, error)
                return
            }

            let cityWeather = CityWeather(city: weatherResponse.name, lat: weatherResponse.coord.lat, lon: weatherResponse.coord.lon, temp: weatherResponse.main.temp, minTemp: weatherResponse.main.temp_min, maxTemp: weatherResponse.main.temp_max, iconURL: "")
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
    let name: String
    let cod: Int
    let coord: Coord
    let main: Main

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




