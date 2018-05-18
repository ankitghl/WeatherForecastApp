//
//	List.swift
//
//	Create by Ankit G on 18/5/2018
//	Copyright © 2018. All rights reserved.

import Foundation

struct List{

	var clouds : Cloud!
	var dt : Int!
	var dtTxt : String!
	var main : Main!
	var rain : Rain!
	var sys : Sy!
	var weather : [Weather]!
	var wind : Wind!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let cloudsData = dictionary["clouds"] as? [String:Any]{
				clouds = Cloud(fromDictionary: cloudsData)
			}
		dt = dictionary["dt"] as? Int
		dtTxt = dictionary["dt_txt"] as? String
		if let mainData = dictionary["main"] as? [String:Any]{
				main = Main(fromDictionary: mainData)
			}
		if let rainData = dictionary["rain"] as? [String:Any]{
				rain = Rain(fromDictionary: rainData)
			}
		if let sysData = dictionary["sys"] as? [String:Any]{
				sys = Sy(fromDictionary: sysData)
			}
		weather = [Weather]()
		if let weatherArray = dictionary["weather"] as? [[String:Any]]{
			for dic in weatherArray{
				let value = Weather(fromDictionary: dic)
				weather.append(value)
			}
		}
		if let windData = dictionary["wind"] as? [String:Any]{
				wind = Wind(fromDictionary: windData)
			}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if clouds != nil{
			dictionary["clouds"] = clouds.toDictionary()
		}
		if dt != nil{
			dictionary["dt"] = dt
		}
		if dtTxt != nil{
			dictionary["dt_txt"] = dtTxt
		}
		if main != nil{
			dictionary["main"] = main.toDictionary()
		}
		if rain != nil{
			dictionary["rain"] = rain.toDictionary()
		}
		if sys != nil{
			dictionary["sys"] = sys.toDictionary()
		}
		if weather != nil{
			var dictionaryElements = [[String:Any]]()
			for weatherElement in weather {
				dictionaryElements.append(weatherElement.toDictionary())
			}
			dictionary["weather"] = dictionaryElements
		}
		if wind != nil{
			dictionary["wind"] = wind.toDictionary()
		}
		return dictionary
	}

}
