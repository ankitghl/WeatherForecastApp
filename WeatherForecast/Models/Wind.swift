//
//	Wind.swift
//
//	Create by Ankit G on 18/5/2018
//	Copyright © 2018. All rights reserved.

import Foundation

struct Wind{

	var deg : Float!
	var speed : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		deg = dictionary["deg"] as? Float
		speed = dictionary["speed"] as? Float
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if deg != nil{
			dictionary["deg"] = deg
		}
		if speed != nil{
			dictionary["speed"] = speed
		}
		return dictionary
	}

}
