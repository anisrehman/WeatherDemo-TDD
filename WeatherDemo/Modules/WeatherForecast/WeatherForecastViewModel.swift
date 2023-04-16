//
//  WeatherForecastViewModel.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 05/03/2023.
//

import Foundation
import Combine

class WeatherForecastViewModel {
    let weatherService: WeatherServiceProtocol
    let city: String

    @Published var forecasts: [WeatherForecast] = []

    init(weatherService: WeatherServiceProtocol, city: String) {
        self.weatherService = weatherService
        self.city = city
    }

    func fetchWeatherForecast() {
        Task {
            forecasts = await weatherService.getWeatherForecast(cityName: city)
        }
    }
}
