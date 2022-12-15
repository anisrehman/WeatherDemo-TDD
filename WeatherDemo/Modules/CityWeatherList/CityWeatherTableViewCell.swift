//
//  CityWeatherTableViewCell.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 12/12/2022.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(weather: CityWeather) {
        cityLabel.text = weather.city
        tempLabel.text = "\(weather.temp.formatted())°C"
        maxTempLabel.text = "\(weather.maxTemp.formatted())°C"
        minTempLabel.text = "\(weather.minTemp.formatted())°C"
    }
    
}
