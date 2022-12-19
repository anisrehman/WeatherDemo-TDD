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
        let request = URLRequest(url: URL(string: "https://google.com")!)
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




