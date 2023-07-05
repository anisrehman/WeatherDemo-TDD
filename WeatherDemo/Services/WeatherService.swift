//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(cityNameList: [String]) async -> [CityWeather]
    func getWeatherForcastGroupedByDate(cityName: String) async -> [ForecastGroup]
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

    func getWeatherForcastGroupedByDate(cityName: String) async -> [ForecastGroup] {
        let forecasts = await getWeatherForecast(cityName: cityName)
        
        var groupByDate: [ForecastGroup] = []
        var index = 0
        var date = forecasts.count > index ? forecasts[index].date : ""
        var sameDateForecasts: [WeatherForecast] = []
        while (index < forecasts.count) {
            if date == forecasts[index].date {
                sameDateForecasts.append(forecasts[index])
            } else {
                let forecastGroup = ForecastGroup(date: date, forecasts: sameDateForecasts)
                groupByDate.append(forecastGroup)
                date = forecasts[index].date
                sameDateForecasts = []
            }
            index += 1
        }
        return groupByDate
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
            let weatherResponse: WeatherResponse = try await apiClient.sendRequest(request)

            guard let name = weatherResponse.name,
                  let main = weatherResponse.main,
                  let coord = weatherResponse.coord,
                  let weather = weatherResponse.weather?[0] else {
                return nil
            }
            let iconURL = "\(iconBaseURL)\(weather.icon)@2x.png"
            let cityWeather = CityWeather(city: name, lat: coord.lat, lon: coord.lon, temp: main.temp, minTemp: main.temp_min, maxTemp: main.temp_max, iconURL: iconURL)
            return cityWeather
        } catch {
            return nil
        }
    }
    
    private func getWeatherForecast(cityName: String) async -> [WeatherForecast] {
        let parameters = [Constant.APIParameter.query: cityName, Constant.APIParameter.appID: Constant.apiKey]
        let urlComponents = URLComponents(string: Constant.getForecastURL, parameters: parameters)
        let url = urlComponents.url!
        let request = URLRequest(url: url)

        do {
            let forecastResponse: ForecastResponse = try await apiClient.sendRequest(request)
            
            let weatherForecasts = forecastResponse.list.map { forecastResponse in
                let icon = forecastResponse.weather?[0].icon ?? ""
                let iconURL = "\(iconBaseURL)\(icon)@2x.png"
                let components = forecastResponse.dt_txt.components(separatedBy: " ")
                var date = ""
                var time = ""
                if components.count > 0 {
                    date = components[0]
                }
                if components.count > 1 {
                    time = components[1]
                }
                return WeatherForecast(temp: forecastResponse.main.temp, minTemp: forecastResponse.main.temp_min, maxTemp: forecastResponse.main.temp_max, iconURL: iconURL, date: date, time: time)
            }
            
            return weatherForecasts
        } catch {
            return []
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
    
    enum CodingKeys: String, CodingKey {
        case name
        case cod
        case coord
        case main
        case weather
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String?.self, forKey: CodingKeys.name)
        let cod = try? container.decode(Int.self, forKey: CodingKeys.cod)
        if let cod {
            self.cod = cod
        } else {
            let cod = try container.decode(String.self, forKey: CodingKeys.cod)
            self.cod = Int(cod)!
        }
        self.coord = try? container.decode(Coord?.self, forKey: CodingKeys.coord)
        self.main = try? container.decode(WeatherBaseResponse.Main?.self, forKey: CodingKeys.main)
        self.weather = try? container.decode([WeatherBaseResponse.Weather]?.self, forKey: CodingKeys.weather)
        self.message = try? container.decode(String?.self, forKey: CodingKeys.message)
    }
    
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
