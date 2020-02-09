//
//  ForecastWeatherTableViewCell.swift
//  WeatherTest
//
//  Created by Macintosh on 04/02/2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

class ForecastWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconForecast: UIImageView!
    @IBOutlet weak var dateForecast: UILabel!
    @IBOutlet weak var descriptionForecast: UILabel!
    @IBOutlet weak var tempForecast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
