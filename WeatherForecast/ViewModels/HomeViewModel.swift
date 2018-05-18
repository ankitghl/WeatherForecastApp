//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by Ankit.G on 17/05/18.
//  Copyright © 2018 Ankit.Gohel. All rights reserved.
//

import Foundation
import CoreLocation

protocol HomeViewDelegate: class {
    func didDetectedLocation(for index: Int)
}

class HomeViewModel: NSObject {

    //MARK: - Properties
    var citiesArray = ["Pune", "Mumbai", "Delhi", "Nashik", "Bangalore", "Chennai", "Rajkot", "Kolkata"]
    var filteredCitiesArray = [String]()
    var didDetectCurentCity: Bool = false

    private weak var delegate: HomeViewDelegate?

    //MARK: -  Initialisers
    init(with delegate: HomeViewDelegate) {
        self.delegate = delegate
    }

    //MARK: -  Helper Methods

    func filterContentForSearchText(_ searchText: String) {
        filteredCitiesArray = (citiesArray.filter({( city : String) -> Bool in
            return city.lowercased().contains(searchText.lowercased())
        }))
    }
    
    func getAddressFromLatLon(lat: Double, withLongitude lon: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    if let currentCity = pm.locality {
                        var index = 0
                        if self.citiesArray.contains(currentCity) {
                            index = self.citiesArray.index(of: currentCity)!
                        } else {
                            self.citiesArray.insert(currentCity, at: 0)
                        }
                        self.delegate?.didDetectedLocation(for: index)
                    }
                }
        })
        
    }

}
