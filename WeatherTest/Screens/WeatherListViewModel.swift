//
//  WeatherListViewModel.swift
//  WeatherTest
//
//  Created by Macintosh on 01/02/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import CoreData

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
                print(self.weatherList)
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
           print("load =  \(self.forecastList?.list?.count)")
           }
        }
    }
    
    func numberOfRowsInSection() -> Int {
         print("num =  \(self.forecastList?.list?.count)")
        return forecastList?.list?.count ?? 0
       }
       
    func cellHight()->CGFloat {
           return 104
       }
    
//    func saveForecastWeatherData(w:WeatherInfo) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "WeatherInfo", in: context)
//        let weatherInfo = NSManagedObject(entity: entity!, insertInto: context)
//        weatherInfo.setValue(forecastList.first?.list?.first?.main?.temp, forKey: "temper")
//        weatherInfo.setValue(forecastList.first?.list?.first?.dt_txt, forKey: "date")
//        weatherInfo.setValue(forecastList.first?.list?.first?.weather?.first?.description, forKey: "discr")
//        weatherInfo.setValue(forecastList.first?.list?.first?.weather?.first?.icon, forKey: "icon")
//        do {
//            try context.save()
//        } catch {
//            self.delegate?.showError(error: "Saving error" )
//        }
//    }
    
    
}


