//
//  CityWeaherListViewController.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 30/11/2022.
//

import UIKit

class CityWeatherListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cityWeatherList: [CityWeather] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension CityWeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityWeatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension CityWeatherListViewController: UITableViewDelegate {

}

