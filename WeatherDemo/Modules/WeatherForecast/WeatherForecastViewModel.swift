//
//  WeatherForecastViewModel.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 05/03/2023.
//

import Foundation
import Combine

class WeatherForecastViewModel {
    @Published var forecasts: [CityWeather] = []
    let weatherService: WeatherServiceProtocol
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
}
