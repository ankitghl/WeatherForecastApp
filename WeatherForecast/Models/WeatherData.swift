//
//	WeatherData.swift
//
//	Create by Ankit G on 18/5/2018
//	Copyright © 2018. All rights reserved.

import Foundation

struct WeatherData{

	var city : City!
	var cnt : Int!
	var cod : String!
	var list : [List]!
	var message : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let cityData = dictionary["city"] as? [String:Any]{
				city = City(fromDictionary: cityData)
			}
		cnt = dictionary["cnt"] as? Int
		cod = dictionary["cod"] as? String
		list = [List]()
		if let listArray = dictionary["list"] as? [[String:Any]]{
			for dic in listArray{
				let value = List(fromDictionary: dic)
				list.append(value)
			}
		}
		message = dictionary["message"] as? Float
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if city != nil{
			dictionary["city"] = city.toDictionary()
		}
		if cnt != nil{
			dictionary["cnt"] = cnt
		}
		if cod != nil{
			dictionary["cod"] = cod
		}
		if list != nil{
			var dictionaryElements = [[String:Any]]()
			for listElement in list {
				dictionaryElements.append(listElement.toDictionary())
			}
			dictionary["list"] = dictionaryElements
		}
		if message != nil{
			dictionary["message"] = message
		}
		return dictionary
	}

}
