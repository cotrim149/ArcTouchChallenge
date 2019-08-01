//
//  MovieImageConfiguration.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 01/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieImageConfiguration: Mappable {
	var base_url : String?
	var secure_base_url : String?
	var backdrop_sizes : [String]?
	var logo_sizes : [String]?
	var poster_sizes : [String]?
	var profile_sizes : [String]?
	var still_sizes : [String]?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		
		base_url <- map["base_url"]
		secure_base_url <- map["secure_base_url"]
		backdrop_sizes <- map["backdrop_sizes"]
		logo_sizes <- map["logo_sizes"]
		poster_sizes <- map["poster_sizes"]
		profile_sizes <- map["profile_sizes"]
		still_sizes <- map["still_sizes"]
	}
}
