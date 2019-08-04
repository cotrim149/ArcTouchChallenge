//
//  ProductionCompanies.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 04/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductionCompanies : Mappable {
	var id : Int?
	var logoPath : String?
	var name : String?
	var originCountry : String?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		
		id <- map["id"]
		logoPath <- map["logo_path"]
		name <- map["name"]
		originCountry <- map["origin_country"]
	}
	
}
