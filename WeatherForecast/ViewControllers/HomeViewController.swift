//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Ankit.G on 17/05/18.
//  Copyright © 2018 Ankit.Gohel. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, CLLocationManagerDelegate, HomeViewDelegate {
    
    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Private Properties
    private let cellIdentifier: String = "CityViewCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: HomeViewModel?
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableCell()
        configureNavigationBar()
        searchBarInit()
        viewModel = HomeViewModel(with: self)
        initialiseLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineLocationPermission()
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
        self.title = "Weather Map"
    }
    
    private func searchBarInit() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
    }
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    private func initialiseLocationManager() {
        // 2. setup locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    }
    
    private func determineLocationPermission() {
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            //            showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. we do have authorization
        else {
            locationManager.startUpdatingLocation()
        }
    }

    
    //MARK:- Table DataSource and Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return (viewModel?.filteredCitiesArray.count)!
        }
        return (viewModel?.citiesArray.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        }
        cell.selectionStyle = .none
        let city: String
        if isFiltering() {
            city = (viewModel?.filteredCitiesArray[indexPath.row])!
        } else {
            city = (viewModel?.citiesArray[indexPath.row])!
        }
        cell.textLabel!.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
            let city: String
            if isFiltering() {
                city = (viewModel?.filteredCitiesArray[indexPath.row])!
            } else {
                city = (viewModel?.citiesArray[indexPath.row])!
            }
            viewController.cityName = city
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    // MARK: - Search Bar Delegates
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel?.filterContentForSearchText(searchBar.text!)
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.filterContentForSearchText(searchController.searchBar.text!)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
            let city: String = searchBar.text!
            viewController.cityName = city
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }

    }

    // MARK: - CLLocation Delegates

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        viewModel?.getAddressFromLatLon(lat: locValue.latitude, withLongitude: locValue.longitude)
    }
    
    // MARK: - Home ViewModel Delegates

    func didDetectedLocation(for index: Int) {
        
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.detailTextLabel?.text = "Current City"
        }
    }

}
