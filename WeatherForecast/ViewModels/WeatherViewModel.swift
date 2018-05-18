
//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Ankit.G on 18/05/18.
//  Copyright © 2018 Ankit.Gohel. All rights reserved.
//

import UIKit

protocol WeatherViewDelegate: class {
    func didReceiveData()
    func didFailToReceiveData(message: String)
}

class WeatherViewModel: NSObject {
    private weak var delegate: WeatherViewDelegate?
    private var networkWrapper: NetworkWrapper?
    
    var weatherData: WeatherData?
    
    //MARK: -  Initialisers
    init(with delegate: WeatherViewDelegate) {
        self.delegate = delegate
        networkWrapper = NetworkWrapper()
    }

    //MARK: -  Helpers
    
    func getAPIURL(for city: String) -> String {
        let urlString = Constants.APIURL + "?q=\(city)&appid=\(Constants.APIKey)"
        return urlString
    }
    
    func getIconURL(for name: String) -> String {
        let urlString = Constants.IconURL + "\(name).png"
        return urlString
    }


    func convertToCelsius(kelvinTemp: Float) -> String {
        return String(format: "%.0f", kelvinTemp - 273.15)
    }

    func convertTimeIntervalToDate(time: Int) -> (Day: Int, WeekDay: String) {
        let weekdays = [
            "SUN",
            "MON",
            "TUE",
            "WED",
            "THU",
            "FRI",
            "SAT,"
        ]

        let date = Date(timeIntervalSince1970: TimeInterval(time))
        print(date)
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let weekDay = calendar.component(.weekday, from: date)
        let weekDayShort = weekdays[weekDay - 1]
        print("Date = \(day):\(weekDayShort)")

        return (day, weekDayShort)
        
    }
    
    //MARK: -  API Calls
    
    func getWeatherDetails(for city: String) {
        networkWrapper?.callAPI(with: getAPIURL(for: city), onSuccess: { (response) in
            if let _response = response as? [String : Any] {
                self.weatherData = WeatherData(fromDictionary: _response)
                self.delegate?.didReceiveData()
            } else {
                self.delegate?.didFailToReceiveData(message: Constants.APIError)
            }
        }, onFailure: { (errorMessage) in
            self.delegate?.didFailToReceiveData(message: Constants.APIError)
        })
    }
    
    func  downloadImage(with name: String, imageView: UIImageView) {
        networkWrapper?.downloadImage(urlstring: getIconURL(for: name), onSuccess: { (responseImage) in
            imageView.image = responseImage
        }, onFailure: { (errorMessage) in
            
        })
    }
    

}
