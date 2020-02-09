//
//  APIManager.swift
//  WeatherTest
//
//  Created by Macintosh on 30/01/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import Alamofire


class APIManager {
    
    private init() {}
    
    static let shared = APIManager()
    
    func loadWeather (_ completion: @escaping (DataForWeather?, String?) -> Void) {
            Alamofire.request(urlWeather).responseJSON { (responce) in
                if let error = responce.error {
                    completion(nil, error.localizedDescription)
                }
                let result = responce.data
                 do {
                    let weatherData = try JSONDecoder().decode(DataForWeather.self, from: result!)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, "Parsing error!")
                }
        }
    }
    
    func loadWeatherForecast (_ completion: @escaping (DataForForecast?, String?) -> Void) {
            Alamofire.request(urlForecast).responseJSON { (responce) in
                if let error = responce.error {
                    completion(nil, error.localizedDescription)
                }
                let result = responce.data
                 do {
                    let forecastDataArray = try JSONDecoder().decode(DataForForecast.self, from: result!)
                    completion(forecastDataArray, nil)
                } catch {
                    completion(nil, "Parsing error!")
                }
        }
    }

}




