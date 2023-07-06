//
//  Constants.swift
//  WeatherDemoTests
//
//  Created by Anis Ur Rehman on 03/07/2023.
//

import Foundation

func cityWeatherSuccessResponse(for city: String) -> String {
    return """
    {
        "coord": {
            "lon": 71.4753,
            "lat": 30.1956
        },
        "weather": [
            {
                "id": 721,
                "main": "Haze",
                "description": "haze",
                "icon": "50d"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 312.09,
            "feels_like": 319.09,
            "temp_min": 312.09,
            "temp_max": 312.09,
            "pressure": 998,
            "humidity": 44
        },
        "visibility": 5000,
        "wind": {
            "speed": 6.17,
            "deg": 270
        },
        "clouds": {
            "all": 0
        },
        "dt": 1688368586,
        "sys": {
            "type": 1,
            "id": 7586,
            "country": "PK",
            "sunrise": 1688343392,
            "sunset": 1688393974
        },
        "timezone": 18000,
        "id": 1169825,
        "name": "\(city)",
        "cod": 200
    }
    """
}
let forecastSuccessResponse = """
{
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
        {
            "dt": 1688374800,
            "main": {
                "temp": 314.22,
                "feels_like": 321.22,
                "temp_min": 314.22,
                "temp_max": 318.47,
                "pressure": 997,
                "sea_level": 997,
                "grnd_level": 981,
                "humidity": 36,
                "temp_kf": -4.25
            },
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.11,
                "deg": 218,
                "gust": 3.49
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-03 09:00:00"
        },
        {
            "dt": 1688385600,
            "main": {
                "temp": 316.88,
                "feels_like": 321.65,
                "temp_min": 316.88,
                "temp_max": 319.28,
                "pressure": 995,
                "sea_level": 995,
                "grnd_level": 979,
                "humidity": 26,
                "temp_kf": -2.4
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 3.42,
                "deg": 205,
                "gust": 4.07
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-03 12:00:00"
        },
        {
            "dt": 1688396400,
            "main": {
                "temp": 316.68,
                "feels_like": 318.96,
                "temp_min": 316.68,
                "temp_max": 316.68,
                "pressure": 993,
                "sea_level": 993,
                "grnd_level": 979,
                "humidity": 22,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 1
            },
            "wind": {
                "speed": 6.11,
                "deg": 188,
                "gust": 8.95
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-03 15:00:00"
        },
        {
            "dt": 1688407200,
            "main": {
                "temp": 314.82,
                "feels_like": 317.14,
                "temp_min": 314.82,
                "temp_max": 314.82,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 980,
                "humidity": 25,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 6.84,
                "deg": 199,
                "gust": 11.75
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-03 18:00:00"
        },
        {
            "dt": 1688418000,
            "main": {
                "temp": 312.74,
                "feels_like": 315.08,
                "temp_min": 312.74,
                "temp_max": 312.74,
                "pressure": 993,
                "sea_level": 993,
                "grnd_level": 979,
                "humidity": 29,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 8.72,
                "deg": 214,
                "gust": 14.27
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-03 21:00:00"
        },
        {
            "dt": 1688428800,
            "main": {
                "temp": 311.11,
                "feels_like": 312.87,
                "temp_min": 311.11,
                "temp_max": 311.11,
                "pressure": 993,
                "sea_level": 993,
                "grnd_level": 979,
                "humidity": 31,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 8.97,
                "deg": 215,
                "gust": 14.82
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-04 00:00:00"
        },
        {
            "dt": 1688439600,
            "main": {
                "temp": 311.65,
                "feels_like": 314.62,
                "temp_min": 311.65,
                "temp_max": 311.65,
                "pressure": 995,
                "sea_level": 995,
                "grnd_level": 981,
                "humidity": 33,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 9.77,
                "deg": 213,
                "gust": 14.01
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-04 03:00:00"
        },
        {
            "dt": 1688450400,
            "main": {
                "temp": 316.23,
                "feels_like": 317.19,
                "temp_min": 316.23,
                "temp_max": 316.23,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 980,
                "humidity": 20,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 10.52,
                "deg": 217,
                "gust": 13.28
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-04 06:00:00"
        },
        {
            "dt": 1688461200,
            "main": {
                "temp": 318.94,
                "feels_like": 319.29,
                "temp_min": 318.94,
                "temp_max": 318.94,
                "pressure": 992,
                "sea_level": 992,
                "grnd_level": 978,
                "humidity": 16,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 9.55,
                "deg": 216,
                "gust": 11.27
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-04 09:00:00"
        },
        {
            "dt": 1688472000,
            "main": {
                "temp": 318.95,
                "feels_like": 318.73,
                "temp_min": 318.95,
                "temp_max": 318.95,
                "pressure": 989,
                "sea_level": 989,
                "grnd_level": 975,
                "humidity": 15,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 9.65,
                "deg": 206,
                "gust": 10.6
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-04 12:00:00"
        },
        {
            "dt": 1688482800,
            "main": {
                "temp": 316.14,
                "feels_like": 316.13,
                "temp_min": 316.14,
                "temp_max": 316.14,
                "pressure": 989,
                "sea_level": 989,
                "grnd_level": 975,
                "humidity": 18,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 8.22,
                "deg": 187,
                "gust": 12.5
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-04 15:00:00"
        },
        {
            "dt": 1688493600,
            "main": {
                "temp": 313.83,
                "feels_like": 314.22,
                "temp_min": 313.83,
                "temp_max": 313.83,
                "pressure": 991,
                "sea_level": 991,
                "grnd_level": 977,
                "humidity": 22,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 1
            },
            "wind": {
                "speed": 8.63,
                "deg": 204,
                "gust": 13.72
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-04 18:00:00"
        },
        {
            "dt": 1688504400,
            "main": {
                "temp": 311.34,
                "feels_like": 312.93,
                "temp_min": 311.34,
                "temp_max": 311.34,
                "pressure": 992,
                "sea_level": 992,
                "grnd_level": 978,
                "humidity": 30,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 1
            },
            "wind": {
                "speed": 5.07,
                "deg": 237,
                "gust": 9.47
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-04 21:00:00"
        },
        {
            "dt": 1688515200,
            "main": {
                "temp": 307.56,
                "feels_like": 310.15,
                "temp_min": 307.56,
                "temp_max": 307.56,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 979,
                "humidity": 43,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 7
            },
            "wind": {
                "speed": 5.17,
                "deg": 238,
                "gust": 7.95
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-05 00:00:00"
        },
        {
            "dt": 1688526000,
            "main": {
                "temp": 308.52,
                "feels_like": 311.39,
                "temp_min": 308.52,
                "temp_max": 308.52,
                "pressure": 996,
                "sea_level": 996,
                "grnd_level": 981,
                "humidity": 41,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 1
            },
            "wind": {
                "speed": 4.74,
                "deg": 237,
                "gust": 5.54
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-05 03:00:00"
        },
        {
            "dt": 1688536800,
            "main": {
                "temp": 311.79,
                "feels_like": 314.9,
                "temp_min": 311.79,
                "temp_max": 311.79,
                "pressure": 996,
                "sea_level": 996,
                "grnd_level": 981,
                "humidity": 33,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 3.73,
                "deg": 238,
                "gust": 4.56
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-05 06:00:00"
        },
        {
            "dt": 1688547600,
            "main": {
                "temp": 315.08,
                "feels_like": 317.13,
                "temp_min": 315.08,
                "temp_max": 315.08,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 980,
                "humidity": 24,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.18,
                "deg": 215,
                "gust": 4.95
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-05 09:00:00"
        },
        {
            "dt": 1688558400,
            "main": {
                "temp": 315.73,
                "feels_like": 316.84,
                "temp_min": 315.73,
                "temp_max": 315.73,
                "pressure": 992,
                "sea_level": 992,
                "grnd_level": 978,
                "humidity": 21,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.69,
                "deg": 191,
                "gust": 4.79
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-05 12:00:00"
        },
        {
            "dt": 1688569200,
            "main": {
                "temp": 313.76,
                "feels_like": 314.87,
                "temp_min": 313.76,
                "temp_max": 313.76,
                "pressure": 993,
                "sea_level": 993,
                "grnd_level": 979,
                "humidity": 24,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.23,
                "deg": 191,
                "gust": 5.67
            },
            "visibility": 10000,
            "pop": 0.06,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-05 15:00:00"
        },
        {
            "dt": 1688580000,
            "main": {
                "temp": 312.79,
                "feels_like": 314,
                "temp_min": 312.79,
                "temp_max": 312.79,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 980,
                "humidity": 26,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 3
            },
            "wind": {
                "speed": 3.44,
                "deg": 200,
                "gust": 6.42
            },
            "visibility": 10000,
            "pop": 0.11,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-05 18:00:00"
        },
        {
            "dt": 1688590800,
            "main": {
                "temp": 310.63,
                "feels_like": 313.05,
                "temp_min": 310.63,
                "temp_max": 310.63,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 980,
                "humidity": 34,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03n"
                }
            ],
            "clouds": {
                "all": 30
            },
            "wind": {
                "speed": 1.98,
                "deg": 260,
                "gust": 5.16
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-05 21:00:00"
        },
        {
            "dt": 1688601600,
            "main": {
                "temp": 308.61,
                "feels_like": 311.56,
                "temp_min": 308.61,
                "temp_max": 308.61,
                "pressure": 996,
                "sea_level": 996,
                "grnd_level": 982,
                "humidity": 41,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 16
            },
            "wind": {
                "speed": 6.33,
                "deg": 222,
                "gust": 8.53
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-06 00:00:00"
        },
        {
            "dt": 1688612400,
            "main": {
                "temp": 309.66,
                "feels_like": 313.71,
                "temp_min": 309.66,
                "temp_max": 309.66,
                "pressure": 998,
                "sea_level": 998,
                "grnd_level": 983,
                "humidity": 41,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 5.58,
                "deg": 229,
                "gust": 6.55
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-06 03:00:00"
        },
        {
            "dt": 1688623200,
            "main": {
                "temp": 313.65,
                "feels_like": 317.75,
                "temp_min": 313.65,
                "temp_max": 313.65,
                "pressure": 998,
                "sea_level": 998,
                "grnd_level": 984,
                "humidity": 31,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.37,
                "deg": 218,
                "gust": 3.9
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-06 06:00:00"
        },
        {
            "dt": 1688634000,
            "main": {
                "temp": 316.48,
                "feels_like": 319.14,
                "temp_min": 316.48,
                "temp_max": 316.48,
                "pressure": 995,
                "sea_level": 995,
                "grnd_level": 981,
                "humidity": 23,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 1
            },
            "wind": {
                "speed": 4.35,
                "deg": 197,
                "gust": 4.06
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-06 09:00:00"
        },
        {
            "dt": 1688644800,
            "main": {
                "temp": 315.35,
                "feels_like": 317.14,
                "temp_min": 315.35,
                "temp_max": 315.35,
                "pressure": 994,
                "sea_level": 994,
                "grnd_level": 980,
                "humidity": 23,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 23
            },
            "wind": {
                "speed": 2.3,
                "deg": 265,
                "gust": 4.67
            },
            "visibility": 10000,
            "pop": 0.18,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-06 12:00:00"
        },
        {
            "dt": 1688655600,
            "main": {
                "temp": 306.73,
                "feels_like": 310.02,
                "temp_min": 306.73,
                "temp_max": 306.73,
                "pressure": 998,
                "sea_level": 998,
                "grnd_level": 984,
                "humidity": 48,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 60
            },
            "wind": {
                "speed": 6.52,
                "deg": 23,
                "gust": 8.07
            },
            "visibility": 10000,
            "pop": 0.59,
            "rain": {
                "3h": 0.86
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-06 15:00:00"
        },
        {
            "dt": 1688666400,
            "main": {
                "temp": 306.18,
                "feels_like": 309.5,
                "temp_min": 306.18,
                "temp_max": 306.18,
                "pressure": 998,
                "sea_level": 998,
                "grnd_level": 984,
                "humidity": 50,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03n"
                }
            ],
            "clouds": {
                "all": 37
            },
            "wind": {
                "speed": 4.79,
                "deg": 114,
                "gust": 7.34
            },
            "visibility": 10000,
            "pop": 0.6,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-06 18:00:00"
        },
        {
            "dt": 1688677200,
            "main": {
                "temp": 306.53,
                "feels_like": 309.62,
                "temp_min": 306.53,
                "temp_max": 306.53,
                "pressure": 998,
                "sea_level": 998,
                "grnd_level": 983,
                "humidity": 48,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 10
            },
            "wind": {
                "speed": 1.79,
                "deg": 119,
                "gust": 3.08
            },
            "visibility": 10000,
            "pop": 0.23,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-06 21:00:00"
        },
        {
            "dt": 1688688000,
            "main": {
                "temp": 305.66,
                "feels_like": 308.74,
                "temp_min": 305.66,
                "temp_max": 305.66,
                "pressure": 999,
                "sea_level": 999,
                "grnd_level": 984,
                "humidity": 51,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 6
            },
            "wind": {
                "speed": 1.82,
                "deg": 115,
                "gust": 2.92
            },
            "visibility": 10000,
            "pop": 0.59,
            "rain": {
                "3h": 0.85
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-07 00:00:00"
        },
        {
            "dt": 1688698800,
            "main": {
                "temp": 308.22,
                "feels_like": 311.45,
                "temp_min": 308.22,
                "temp_max": 308.22,
                "pressure": 1000,
                "sea_level": 1000,
                "grnd_level": 985,
                "humidity": 43,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": {
                "all": 2
            },
            "wind": {
                "speed": 2.79,
                "deg": 79,
                "gust": 2.34
            },
            "visibility": 10000,
            "pop": 0.42,
            "rain": {
                "3h": 0.99
            },
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-07 03:00:00"
        },
        {
            "dt": 1688709600,
            "main": {
                "temp": 312.54,
                "feels_like": 315.96,
                "temp_min": 312.54,
                "temp_max": 312.54,
                "pressure": 999,
                "sea_level": 999,
                "grnd_level": 985,
                "humidity": 32,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 3
            },
            "wind": {
                "speed": 1.26,
                "deg": 17,
                "gust": 1.01
            },
            "visibility": 10000,
            "pop": 0.34,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-07 06:00:00"
        },
        {
            "dt": 1688720400,
            "main": {
                "temp": 315.3,
                "feels_like": 318.52,
                "temp_min": 315.3,
                "temp_max": 315.3,
                "pressure": 997,
                "sea_level": 997,
                "grnd_level": 983,
                "humidity": 26,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 10
            },
            "wind": {
                "speed": 2.37,
                "deg": 347,
                "gust": 1.58
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-07 09:00:00"
        },
        {
            "dt": 1688731200,
            "main": {
                "temp": 308.23,
                "feels_like": 312.5,
                "temp_min": 308.23,
                "temp_max": 308.23,
                "pressure": 996,
                "sea_level": 996,
                "grnd_level": 982,
                "humidity": 46,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": {
                "all": 40
            },
            "wind": {
                "speed": 8.85,
                "deg": 32,
                "gust": 9.56
            },
            "visibility": 10000,
            "pop": 0.39,
            "rain": {
                "3h": 0.95
            },
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-07 12:00:00"
        },
        {
            "dt": 1688742000,
            "main": {
                "temp": 307.1,
                "feels_like": 310.16,
                "temp_min": 307.1,
                "temp_max": 307.1,
                "pressure": 998,
                "sea_level": 998,
                "grnd_level": 984,
                "humidity": 46,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 53
            },
            "wind": {
                "speed": 1.36,
                "deg": 63,
                "gust": 2.27
            },
            "visibility": 10000,
            "pop": 0.86,
            "rain": {
                "3h": 1.24
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-07 15:00:00"
        },
        {
            "dt": 1688752800,
            "main": {
                "temp": 306.91,
                "feels_like": 310.39,
                "temp_min": 306.91,
                "temp_max": 306.91,
                "pressure": 1000,
                "sea_level": 1000,
                "grnd_level": 986,
                "humidity": 48,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 501,
                    "main": "Rain",
                    "description": "moderate rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 49
            },
            "wind": {
                "speed": 5.4,
                "deg": 316,
                "gust": 6.85
            },
            "visibility": 10000,
            "pop": 0.9,
            "rain": {
                "3h": 3.57
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-07 18:00:00"
        },
        {
            "dt": 1688763600,
            "main": {
                "temp": 302.83,
                "feels_like": 306.35,
                "temp_min": 302.83,
                "temp_max": 302.83,
                "pressure": 999,
                "sea_level": 999,
                "grnd_level": 984,
                "humidity": 65,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 58
            },
            "wind": {
                "speed": 7.04,
                "deg": 16,
                "gust": 10.11
            },
            "visibility": 10000,
            "pop": 0.65,
            "rain": {
                "3h": 0.13
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-07 21:00:00"
        },
        {
            "dt": 1688774400,
            "main": {
                "temp": 303.44,
                "feels_like": 306.54,
                "temp_min": 303.44,
                "temp_max": 303.44,
                "pressure": 1000,
                "sea_level": 1000,
                "grnd_level": 985,
                "humidity": 60,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 72
            },
            "wind": {
                "speed": 6.41,
                "deg": 1,
                "gust": 9
            },
            "visibility": 10000,
            "pop": 0.7,
            "rain": {
                "3h": 0.28
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2023-07-08 00:00:00"
        },
        {
            "dt": 1688785200,
            "main": {
                "temp": 304.79,
                "feels_like": 307.56,
                "temp_min": 304.79,
                "temp_max": 304.79,
                "pressure": 1001,
                "sea_level": 1001,
                "grnd_level": 986,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": {
                "all": 16
            },
            "wind": {
                "speed": 6.27,
                "deg": 9,
                "gust": 8.3
            },
            "visibility": 10000,
            "pop": 0.95,
            "rain": {
                "3h": 2.15
            },
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-08 03:00:00"
        },
        {
            "dt": 1688796000,
            "main": {
                "temp": 308.09,
                "feels_like": 312.2,
                "temp_min": 308.09,
                "temp_max": 308.09,
                "pressure": 1001,
                "sea_level": 1001,
                "grnd_level": 987,
                "humidity": 46,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10d"
                }
            ],
            "clouds": {
                "all": 39
            },
            "wind": {
                "speed": 4.74,
                "deg": 29,
                "gust": 5.46
            },
            "visibility": 10000,
            "pop": 0.86,
            "rain": {
                "3h": 0.38
            },
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2023-07-08 06:00:00"
        }
    ],
    "city": {
        "id": 1169825,
        "name": "Multan",
        "coord": {
            "lat": 30.1956,
            "lon": 71.4753
        },
        "country": "PK",
        "population": 1437230,
        "timezone": 18000,
        "sunrise": 1688343392,
        "sunset": 1688393974
    }
}
"""

let invalidCityWeatherResponse = """
{
    "cod": "404",
    "message": "city not found"
}
"""
