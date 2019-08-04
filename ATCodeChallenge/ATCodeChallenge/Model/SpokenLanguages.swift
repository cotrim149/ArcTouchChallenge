//
//  SpokenLanguages.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 04/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class SpokenLanguages : Mappable {
	var iso_639_1 : String?
	var name : String?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		
		iso_639_1 <- map["iso_639_1"]
		name <- map["name"]
	}
	
}
