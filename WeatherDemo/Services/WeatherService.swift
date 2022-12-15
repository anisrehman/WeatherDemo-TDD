//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 15/12/2022.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    func getWeather(cityNameList: [String], completion: @escaping ([CityWeather]?) -> Void) {

    }
}
