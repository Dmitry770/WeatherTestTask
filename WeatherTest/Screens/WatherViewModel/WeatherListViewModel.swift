//
//  WeatherListViewModel.swift
//  WeatherTest
//
//  Created by Macintosh on 01/02/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

protocol WeatherListViewModelDelegate: class {
    func reloadData()
    func showError(error: String)
}

class WeatherListViewModel {
    
    weak var delegate: WeatherListViewModelDelegate?
    
    var weatherList : DataForWeather?
    var forecastList : DataForForecast?
    
    
    init(delegate: WeatherListViewModelDelegate) {
        self.delegate = delegate
    }
    
    
    func getWeatherList() {
        APIManager.shared.loadWeather { (weatherList, error) in
            if let error = error {
                self.delegate?.showError(error: error)
            } else if let weatherList = weatherList {
                self.weatherList = weatherList
                self.delegate?.reloadData()
            }
        }
    }
    
    func getForecastList() {
        APIManager.shared.loadWeatherForecast { (forecastList, error) in
        if let error = error {
            self.delegate?.showError(error: error)
        } else if let forecastList = forecastList {
            self.forecastList = forecastList
            self.delegate?.reloadData()
           }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return forecastList?.list?.count ?? 0
       }
       
    func cellHight()->CGFloat {
           return 104
       }
    
    
}


