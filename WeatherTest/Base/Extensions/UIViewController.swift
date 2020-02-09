//
//  UIViewController.swift
//  WeatherTest
//
//  Created by Macintosh on 30/01/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, _ handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(buttonOk)
        present(alert, animated: true)
    }
    
}
