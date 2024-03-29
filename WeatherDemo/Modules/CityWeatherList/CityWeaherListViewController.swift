//
//  CityWeaherListViewController.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 30/11/2022.
//

import UIKit
import Combine

class CityWeatherListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: CityWeatherListViewModel!
    var router: CityWeatherRouter!
//    var didSelectCity: ((String) -> Void)?

    private var cityWeatherList: [CityWeather] = []
    private var subscribers: [AnyCancellable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindViews()
        Task {
            await viewModel.fetchCityWeathers()
        }
    }
}

//MARK: - Private Functions
extension CityWeatherListViewController {
    private func setupUI() {
        tableView.register(UINib(nibName: "CityWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "CityWeatherTableViewCell")
    }

    private func bindViews() {
        viewModel.$cityWeatherList.sink { cityWeathers in
            DispatchQueue.main.async { [weak self] in
                self?.cityWeatherList = cityWeathers
                self?.tableView.reloadData()
            }
        }.store(in: &subscribers)
    }
}

//MARK: - UITableViewDataSource
extension CityWeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
        cell.configure(weather: cityWeatherList[indexPath.row])
        return cell
    }
}

extension CityWeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.didSelectCity?(cityWeatherList[indexPath.row].city)
        router.showWeatherForecast(city: cityWeatherList[indexPath.row].city)
    }
}

