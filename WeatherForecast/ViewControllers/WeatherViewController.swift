//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by Ankit.G on 18/05/18.
//  Copyright © 2018 Ankit.Gohel. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewDelegate, UITableViewDelegate, UITableViewDataSource {

    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Private Properties
    private let cellIdentifier: String = "CityViewCell"
    private let cellHeight: CGFloat = 118.0
    private var viewModel: WeatherViewModel?
    
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableCell()
        configureNavigationBar()
        viewModel = WeatherViewModel(with: self)
        fetchWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Private Helpers
    
    private func registerTableCell() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func configureNavigationBar() {
        self.title = cityName
    }
    
    private func fetchWeather() {
        showLoading()
        viewModel?.getWeatherDetails(for: cityName)
    }
    
    private func showLoading() {
        tableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoading() {
        tableView.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: Constants.AppName, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)

    }

    //MARK:- Table DataSource and Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel?.weatherData?.cnt {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CityViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityViewCell {
            cell.selectionStyle = .none

            let weatherData = viewModel?.weatherData?.list[indexPath.row]
            let iconName = weatherData?.weather.first?.icon
            
            viewModel?.downloadImage(with: iconName!, imageView: cell.imageWeather!)
            
            if let date = weatherData?.dt {
                let dateConverted = (viewModel?.convertTimeIntervalToDate(time: date))!
                cell.labelDay.text = dateConverted.WeekDay
                cell.labelDate.text = "\(dateConverted.Day)"
            }
            
            cell.labelCity.text = viewModel?.weatherData?.city.name
            cell.labelWeather.text = weatherData?.weather.first?.descriptionField
            if let humidity = weatherData?.main.humidity {
                cell.labelHumidity.text = String(format: "%d", humidity) + " %"
            }
            if let temp = weatherData?.main.temp {
                cell.labelTemperature.text = viewModel?.convertToCelsius(kelvinTemp: temp)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    // MARK: - Weather ViewModel Delegates
    func didReceiveData() {
        hideLoading()
        tableView.reloadData()
    }
    
    func didFailToReceiveData(message: String) {
        hideLoading()
        showAlert(with: message)
    }

}
