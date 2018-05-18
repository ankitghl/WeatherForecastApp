//
//	Cloud.swift
//
//	Create by Ankit G on 18/5/2018
//	Copyright © 2018. All rights reserved.

import Foundation

struct Cloud{

	var all : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		all = dictionary["all"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if all != nil{
			dictionary["all"] = all
		}
		return dictionary
	}

}
