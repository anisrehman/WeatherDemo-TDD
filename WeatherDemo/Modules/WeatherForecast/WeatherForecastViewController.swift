//
//  WeatherForecastViewController.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 21/02/2023.
//

import UIKit
import Combine

class WeatherForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: WeatherForecastViewModel!

    private var subscribers: [AnyCancellable] = []

    private var forecastGroups: [ForecastGroup] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindViews()
        
        viewModel.fetchWeatherForecast()
    }
}

extension WeatherForecastViewController {

    private func setupUI() {
        tableView.register(UINib(nibName: "WeatherForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherForecastTableViewCell")
    }

    private func bindViews() {
        viewModel.$forecastGroups.sink { forecastGroups in
            DispatchQueue.main.async { [weak self] in
                self?.forecastGroups = forecastGroups
                self?.tableView.reloadData()
            }
        }.store(in: &subscribers)
    }
}

extension WeatherForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        forecastGroups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        forecastGroups[section].date
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastGroups[section].forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherForecastTableViewCell", for: indexPath) as! WeatherForecastTableViewCell
        
        let forecast = forecastGroups[indexPath.section].forecasts[indexPath.row]
        cell.configure(forecast: forecast)
        return cell
    }
}
