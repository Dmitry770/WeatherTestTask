//
//  WeatherListViewController.swift
//  WeatherTest
//
//  Created by Macintosh on 01/02/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherListViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    var viewModel: WeatherListViewModel?
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        startLocationManager()
        self.viewModel = WeatherListViewModel(delegate: self)
        self.viewModel?.getWeatherList()
    }
        
    
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
           if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
                locationManager.pausesLocationUpdatesAutomatically = false
                locationManager.startUpdatingLocation()
              }
    }
        
}

extension WeatherListViewController: WeatherListViewModelDelegate {
    
    func reloadData() {
        //optional
        guard
            let name = viewModel?.weatherList?.name,
            let temp = viewModel?.weatherList?.main?.temp,
            let description = viewModel?.weatherList?.weather?.first?.main,
            let humidity = viewModel?.weatherList?.main?.humidity
            
            else {return}
        cityLabel.text = name
        tempLabel.text = "\(temp)  C"
        descriptionLabel.text = description
        humidityLabel.text = "Humidity: \(humidity)  %"
        pressureLabel.text = "Pressure: \(self.viewModel?.weatherList?.main?.pressure ?? 0)  hPa"
        feelsLikeLabel.text = "Feels Like: \(viewModel?.weatherList?.main?.feels_like ?? 0)  C"
        iconImage.image = UIImage(named: viewModel?.weatherList?.weather?.first?.icon ?? "01d")
    }
    
    func showError(error: String) {
        showAlert(title: error, message: nil, nil)
    }
}

extension WeatherListViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            Location.sharedInstance.latitude = lastLocation.coordinate.latitude
            Location.sharedInstance.longitude = lastLocation.coordinate.longitude
            print(Location.sharedInstance.latitude!, Location.sharedInstance.longitude!)
            urlWeather = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&lang=ru&APPID=d01ef7e74ff4af273f72901d3daddaec"
            urlForecast = "https://openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=b6907d289e10d714a6e88b30761fae22"
            self.viewModel?.getWeatherList()
            self.viewModel?.getForecastList()
//            self.viewModel?.saveForecastWeatherData()
        }
    }
}


