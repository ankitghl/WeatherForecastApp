//
//	Coord.swift
//
//	Create by Ankit G on 18/5/2018
//	Copyright © 2018. All rights reserved.

import Foundation

struct Coord{

	var lat : Float!
	var lon : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		lat = dictionary["lat"] as? Float
		lon = dictionary["lon"] as? Float
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if lat != nil{
			dictionary["lat"] = lat
		}
		if lon != nil{
			dictionary["lon"] = lon
		}
		return dictionary
	}

}
