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
    let cityList = ["Islamabad", "Karachi", "Lahore", "Peshawar", "Quetta", "Multan"]
    
    //MARK: - Initializers
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    //MARK: - Public Functions
    func fetchCityWeathers() async {
        let cityWeatherList = await weatherService.getWeather(cityNameList: cityList)
        self.cityWeatherList = cityWeatherList
    }
}
