//
//  UpcomingMovies.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 01/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class UpcomingMovies: Mappable {
	var movies: [Movie]?
	var page, totalResults: Int?
	var dates: Dates?
	var totalPages: Int?
	
	required init?(map: Map) {
		
	}

	func mapping(map: Map) {
		self.movies <- map["results"]
		self.page <- map["page"]
		self.totalResults <- map["totalResults"]
		self.dates <- map["dates"]
		self.totalPages <- map["totalPages"]
	}

}

extension UpcomingMovies {
	class Dates: Mappable {
		var maximum, minimum: String?
		
		func mapping(map: Map) {
			self.maximum <- map["maximum"]
			self.minimum <- map["minimum"]
		}

		required init?(map: Map) {
			
		}

	}
}
