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

    @Published var forecastGroups: [ForecastGroup] = []

    init(weatherService: WeatherServiceProtocol, city: String) {
        self.weatherService = weatherService
        self.city = city
    }

    func fetchWeatherForecast() {
        Task {
            forecastGroups = await weatherService.getWeatherForcastGroupedByDate(cityName: city)
        }
    }
}
