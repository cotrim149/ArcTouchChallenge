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
	var baseUrl : String?
	var secureBaseUrl : String?
	var backdropSizes : [String]?
	var logoSizes : [String]?
	var posterSizes : [String]?
	var profileSizes : [String]?
	var stillSizes : [String]?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		
		baseUrl <- map["base_url"]
		secureBaseUrl <- map["secure_base_url"]
		backdropSizes <- map["backdrop_sizes"]
		logoSizes <- map["logo_sizes"]
		posterSizes <- map["poster_sizes"]
		profileSizes <- map["profile_sizes"]
		stillSizes <- map["still_sizes"]
	}
}
