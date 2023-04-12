//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(cityNameList: [String]) async -> [CityWeather]
    func getWeatherForecast(cityName: String) async -> [WeatherForecast]
}

class WeatherService: WeatherServiceProtocol {
    let iconBaseURL = "https://openweathermap.org/img/wn/"
    let apiClient: APIClientProtocol!
    init(client: APIClientProtocol) {
        self.apiClient = client
    }

    func getWeather(cityNameList: [String]) async -> [CityWeather] {
        await withTaskGroup(of: CityWeather?.self, body: { [self] taskGroup in
            let startTime = Date.now
            for cityName in cityNameList {
                taskGroup.addTask {
                    await self.getWeather(cityName: cityName)
                }
            }

            var weathers: [CityWeather] = []
            for await result in taskGroup {
                if let result = result {
                    weathers.append(result)
                }
            }
            print("execution time\(Date.now.distance(to: startTime))")
            return weathers
        })
    }

    func getWeatherForecast(cityName: String) async -> [WeatherForecast] {
        let parameters = [Constant.APIParameter.query: cityName, Constant.APIParameter.appID: Constant.apiKey]
        let urlComponents = URLComponents(string: Constant.getForecastURL, parameters: parameters)
        let url = urlComponents.url!
        let request = URLRequest(url: url)

        do {
            let forecastResponse: ForecastResponse? = try await apiClient.sendRequest(request, with: URLSession.shared)

            guard let list = forecastResponse?.list, list.count > 0 else {
                return []
            }
            let weatherForecasts = list.map { forecastResponse in
                WeatherForecast(temp: forecastResponse.main.temp, minTemp: forecastResponse.main.temp_min, maxTemp: forecastResponse.main.temp_max, iconURL: forecastResponse.weather?[0].icon ?? "", date: forecastResponse.dt_txt)
            }
            
            return weatherForecasts
        } catch {
            return []
        }
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

            guard let weatherResponse = weatherResponse,
                    let name = weatherResponse.name,
                    let main = weatherResponse.main,
                    let coord = weatherResponse.coord,
                    let weather = weatherResponse.weather?[0] else {
                return nil
            }
            let iconURL = "\(iconBaseURL)\(weather.icon)@2x.png"
            debugPrint(iconURL)
            let cityWeather = CityWeather(city: name, lat: coord.lat, lon: coord.lon, temp: main.temp, minTemp: main.temp_min, maxTemp: main.temp_max, iconURL: iconURL)
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

//MARK: - WeatherBaseResponse
struct WeatherBaseResponse {
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
//MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    let name: String?
    let cod: Int
    let coord: Coord?
    let main: WeatherBaseResponse.Main?
    let weather: [WeatherBaseResponse.Weather]?
    let message: String?

    struct Coord: Decodable {
        let lat: Double
        let lon: Double
    }
}

//MARK: - ForecastResponse
struct ForecastResponse: Decodable {
    let cod: String
    let list: [Forecast]

    struct Forecast: Decodable {
        let dt: Int
        let dt_txt: String
        let main: WeatherBaseResponse.Main
        let weather: [WeatherBaseResponse.Weather]?
    }
}
