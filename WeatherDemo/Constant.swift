//
//  Constant.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 19/12/2022.
//

import Foundation

struct Constant {
    static let apiKey = "41e27a0de3ccbda5d8da10a585959685"
    static let apiBaseURL = "https://api.openweathermap.org/data/2.5"
    static let cityWeatherURL = apiBaseURL + "/weather"
    static let forecastURL = apiBaseURL + "/forecast"
    static let kelvinOffset = 273.15
    struct APIParameter {
        static let appID = "appid"
        static let query = "q"
    }
}
