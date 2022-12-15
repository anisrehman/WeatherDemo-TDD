//
//  CityWeatherListViewModel.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 14/12/2022.
//

import Foundation

class CityWeatherListViewModel {
    @Published var cityWeatherList: [CityWeather] = []
    init(cityWeatherList: [CityWeather]) {
        self.cityWeatherList = cityWeatherList
    }

    func fetchCityWeathers() {
        self.cityWeatherList = self.cityWeatherList
    }
}
