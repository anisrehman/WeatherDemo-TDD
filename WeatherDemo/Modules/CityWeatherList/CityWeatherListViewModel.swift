//
//  CityWeatherListViewModel.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 14/12/2022.
//

import Foundation

class CityWeatherListViewModel {
    //MARK: Published Properties
    @Published var cityWeatherList: [CityWeather] = []
    
    //MARK: - Private Properties
    var weatherService: WeatherServiceProtocol!
    let cityList = ["Multan"]
    
    //MARK: - Initializers
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    //MARK: - Public Functions
    func fetchCityWeathers() async {
        try? await weatherService.getWeather(cityNameList: cityList) { [weak self] cityWeatherList in
            self?.cityWeatherList = cityWeatherList ?? []
        }
    }
}
