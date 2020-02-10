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
    
    var locLabel = UILabel()
    var tempLabel = UILabel()
    var descriptionLabel = UILabel()
    var humidityLabel = UILabel()
    var pressureLabel = UILabel()
    var feelsLikeLabel = UILabel()
    var iconWeatherImage = UIImageView()
    var buttonShare = UIButton()
    
    var viewModel: WeatherListViewModel?
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        startLocationManager()
        
        self.viewModel = WeatherListViewModel(delegate: self)
        self.viewModel?.getWeatherList()
        
        view.addSubview(locLabel)
        createLocLabelConstraints()
        view.addSubview(tempLabel)
        createTempLabelConstraints()
        view.addSubview(descriptionLabel)
        createDescriptionLabelConstraints()
        view.addSubview(humidityLabel)
        createHumidityLabelConstraints()
        view.addSubview(pressureLabel)
        createPressureLabelConstraints()
        view.addSubview(feelsLikeLabel)
        createFeelsLikeLabelConstraints()
        view.addSubview(iconWeatherImage)
        createIconWeatherImageConstraints()
        view.addSubview(buttonShare)
        createButtonShareConstraints()
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
        guard
            let name = viewModel?.weatherList?.name,
            let temp = viewModel?.weatherList?.main?.temp,
            let description = viewModel?.weatherList?.weather?.first?.main,
            let humidity = viewModel?.weatherList?.main?.humidity
        else {return}
        
        locLabel.frame = CGRect(x: 10, y: 260, width: self.view.frame.width, height: 150)
        locLabel.translatesAutoresizingMaskIntoConstraints = false
        locLabel.text = name
        locLabel.textAlignment = NSTextAlignment.center
        locLabel.textColor = UIColor.black
        locLabel.font = UIFont(name: "Copperplate-Bold", size: 30)
        
        tempLabel.frame = CGRect(x: 35, y: 350, width: 150, height: 40)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "\(temp)  C"
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.textColor = UIColor.blue
        tempLabel.font = UIFont(name: "Copperplate", size: 23)
        
        descriptionLabel.frame = CGRect(x: 200, y: 350, width: 150, height: 40)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.textAlignment = NSTextAlignment.center
        descriptionLabel.textColor = UIColor.blue
        descriptionLabel.font = UIFont(name: "Copperplate", size: 23)
        
        humidityLabel.frame = CGRect(x: 50, y: 430, width: self.view.frame.width, height: 70)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "Humidity: \(humidity)  %"
        humidityLabel.textAlignment = NSTextAlignment.left
        humidityLabel.textColor = UIColor.black
        humidityLabel.font = UIFont(name: "Copperplate", size: 23)
        
        pressureLabel.frame = CGRect(x: 50, y: 460, width: self.view.frame.width, height: 70)
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.text = "Pressure: \(self.viewModel?.weatherList?.main?.pressure ?? 0)  hPa"
        pressureLabel.textAlignment = NSTextAlignment.left
        pressureLabel.textColor = UIColor.black
        pressureLabel.font = UIFont(name: "Copperplate", size: 23)
        
        feelsLikeLabel.frame = CGRect(x: 50, y: 490, width: self.view.frame.width, height: 70)
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.text = "Feels Like: \(viewModel?.weatherList?.main?.feels_like ?? 0)  C"
        feelsLikeLabel.textAlignment = NSTextAlignment.left
        feelsLikeLabel.textColor = UIColor.black
        feelsLikeLabel.font = UIFont(name: "Copperplate", size: 23)
        
        iconWeatherImage.frame = CGRect(x: 150, y: 120, width: 120, height: 120)
        iconWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        iconWeatherImage.image = UIImage(named: viewModel?.weatherList?.weather?.first?.icon ?? "01d")
        
        buttonShare.frame = CGRect(x: 150, y: 650, width: 100, height: 60)
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.setTitle("Share", for: .normal)
        buttonShare.addTarget(self, action: #selector(shareTappedButton), for: .touchUpInside)
        buttonShare.setTitleColor(.orange, for: .normal)
    }
    
    func createLocLabelConstraints() {
        NSLayoutConstraint(item: locLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: locLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: locLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 260).isActive = true
        NSLayoutConstraint(item: locLabel, attribute: .height, relatedBy: .equal, toItem: locLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    
    func createTempLabelConstraints() {
        NSLayoutConstraint(item: tempLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 60).isActive = true
        NSLayoutConstraint(item: tempLabel, attribute: .width, relatedBy: .equal, toItem: tempLabel, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tempLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 320).isActive = true
        NSLayoutConstraint(item: tempLabel, attribute: .height, relatedBy: .equal, toItem: tempLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
       }
    
    func createDescriptionLabelConstraints() {
        NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: tempLabel, attribute: .leadingMargin, multiplier: 1, constant: 170).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: descriptionLabel, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 320).isActive = true
        NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: descriptionLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
          }
    
    func createHumidityLabelConstraints() {
         NSLayoutConstraint(item: humidityLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 30).isActive = true
         NSLayoutConstraint(item: humidityLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: -30).isActive = true
         NSLayoutConstraint(item: humidityLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 400).isActive = true
         NSLayoutConstraint(item: humidityLabel, attribute: .height, relatedBy: .equal, toItem: humidityLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
     }
    
    func createPressureLabelConstraints() {
         NSLayoutConstraint(item: pressureLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 30).isActive = true
         NSLayoutConstraint(item: pressureLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: -30).isActive = true
         NSLayoutConstraint(item: pressureLabel, attribute: .top, relatedBy: .equal, toItem: humidityLabel, attribute: .topMargin, multiplier: 1, constant: 30).isActive = true
         NSLayoutConstraint(item: pressureLabel, attribute: .height, relatedBy: .equal, toItem: pressureLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
     }
    
    func createFeelsLikeLabelConstraints() {
         NSLayoutConstraint(item: feelsLikeLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 30).isActive = true
         NSLayoutConstraint(item: feelsLikeLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: -30).isActive = true
         NSLayoutConstraint(item: feelsLikeLabel, attribute: .top, relatedBy: .equal, toItem: pressureLabel, attribute: .topMargin, multiplier: 1, constant: 30).isActive = true
         NSLayoutConstraint(item: feelsLikeLabel, attribute: .height, relatedBy: .equal, toItem: feelsLikeLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
     }
    
    func createIconWeatherImageConstraints() {
        NSLayoutConstraint(item: iconWeatherImage, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 110).isActive = true
        NSLayoutConstraint(item: iconWeatherImage, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: -120).isActive = true
        NSLayoutConstraint(item: iconWeatherImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 70).isActive = true
        NSLayoutConstraint(item: iconWeatherImage, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: -590).isActive = true
    }
    
    func createButtonShareConstraints() {
         NSLayoutConstraint(item: buttonShare, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 140).isActive = true
         NSLayoutConstraint(item: buttonShare, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: -170).isActive = true
         NSLayoutConstraint(item: buttonShare, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 600).isActive = true
         NSLayoutConstraint(item: buttonShare, attribute: .height, relatedBy: .equal, toItem: buttonShare, attribute: .height, multiplier: 1, constant: 0).isActive = true
     }

    
    func showError(error: String) {
        showAlert(title: error, message: nil, nil)
    }
    
    @IBAction func shareTappedButton(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: ["My temperature = \(viewModel?.weatherList?.main?.temp ?? 0) C, my location: \(viewModel?.weatherList?.weather?.first?.main ?? "Minsk")"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension WeatherListViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            Location.sharedInstance.latitude = lastLocation.coordinate.latitude
            Location.sharedInstance.longitude = lastLocation.coordinate.longitude
            urlWeather = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&lang=ru&APPID=d01ef7e74ff4af273f72901d3daddaec"
            urlForecast = "https://openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=b6907d289e10d714a6e88b30761fae22"
            self.viewModel?.getWeatherList()
            self.viewModel?.getForecastList()
        }
    }
}


