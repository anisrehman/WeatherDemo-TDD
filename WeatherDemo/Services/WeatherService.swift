//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(cityNameList: [String]) async -> [CityWeather]
}

class WeatherService: WeatherServiceProtocol {
    let apiClient: APIClientProtocol!
    init(client: APIClientProtocol) {
        self.apiClient = client
    }

    func getWeather(cityNameList: [String]) async -> [CityWeather] {
        var cityWeatherList: [CityWeather] = []
        for cityName in cityNameList {
            if let weather = await getWeather(cityName: cityName) {
                cityWeatherList.append(weather)
            }
        }
        return cityWeatherList
    }
}

//MARK: - Private Function
extension WeatherService {
    private func getWeather(cityName: String) async -> CityWeather? {
        let parameters = [Constant.APIParameter.query: cityName, Constant.APIParameter.appID: Constant.apiKey]
        let urlComponents = URLComponents(string: Constant.getCityWeatherURL, parameters: parameters)
        let url = urlComponents.url!
        let request = URLRequest(url: url)

        do {
            let weatherResponse: WeatherResponse? = try await apiClient.sendRequest(request, with: URLSession.shared)

            guard let weatherResponse = weatherResponse, let name = weatherResponse.name, let main = weatherResponse.main, let coord = weatherResponse.coord else {
                return nil
            }

            let cityWeather = CityWeather(city: name, lat: coord.lat, lon: coord.lon, temp: main.temp, minTemp: main.temp_min, maxTemp: main.temp_max, iconURL: "")
            return cityWeather
        } catch {
            return nil
        }
    }
}

//MARK: - URLComponents Extension
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

//MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    let name: String?
    let cod: Int
    let coord: Coord?
    let main: Main?
    let weather: [Weather]?
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

    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}
