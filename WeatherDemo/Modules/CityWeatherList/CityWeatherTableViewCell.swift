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
    @IBOutlet weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(weather: CityWeather) {
        cityLabel.text = weather.city
        tempLabel.text = "\(Int(weather.temp))°"
        maxTempLabel.text = "\(Int(weather.maxTemp))°"
        minTempLabel.text = "\(Int(weather.minTemp))°"
        weatherImageView.setImage(from: "")
        weatherImageView.contentMode = .scaleAspectFill
    }
}
