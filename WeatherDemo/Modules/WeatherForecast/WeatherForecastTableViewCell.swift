//
//  WeatherForecastTableViewCell.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 16/04/2023.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(forecast: WeatherForecast) {
        timeLabel.text = forecast.date
        tempLabel.text = "\(Int(forecast.temp))°"
        weatherImageView.setImage(from: forecast.iconURL)
        weatherImageView.contentMode = .scaleAspectFill
    }
}
