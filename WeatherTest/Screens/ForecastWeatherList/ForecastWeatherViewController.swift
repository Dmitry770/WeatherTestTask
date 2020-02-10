//
//  ForecastWeatherViewController.swift
//  WeatherTest
//
//  Created by Macintosh on 01/02/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

class ForecastWeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: WeatherListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        self.viewModel = WeatherListViewModel(delegate: self)
        self.viewModel?.getForecastList()
    }
    
}

extension ForecastWeatherViewController: WeatherListViewModelDelegate {
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        showAlert(title: error, message: nil, nil)
    }
}

extension ForecastWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.viewModel?.numberOfRowsInSection() ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastWeatherTableViewCell
         if let item  =  viewModel?.forecastList?.list![indexPath.row] {
           cell.descriptionForecast.text = item.weather?.first?.description
           cell.dateForecast.text = item.dt_txt
            if let temp =  item.main?.temp {
                cell.tempForecast.text = String(format:"%.1lf C",temp)
            }
           cell.iconForecast.image = UIImage(named: (viewModel?.forecastList?.list![indexPath.row].weather?.first?.icon)!)
        }
         return cell
     }
    
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return viewModel?.cellHight() ?? 104
     }
}

private extension ForecastWeatherViewController {
    
    func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
       }
}
