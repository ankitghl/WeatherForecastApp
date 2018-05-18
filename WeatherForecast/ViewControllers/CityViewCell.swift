//
//  CityViewCell.swift
//  WeatherForecast
//
//  Created by Ankit.G on 17/05/18.
//  Copyright © 2018 Ankit.Gohel. All rights reserved.
//

import UIKit

class CityViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    
    //MARK: - Cell LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
