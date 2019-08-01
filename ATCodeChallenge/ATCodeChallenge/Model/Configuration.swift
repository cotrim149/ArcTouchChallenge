//
//  Configuration.swift
//  ATCodeChallenge
//
//  Created by Victor de Lima on 01/08/19.
//  Copyright © 2019 Victor Cotrim. All rights reserved.
//

import UIKit
import ObjectMapper

class Configuration: Mappable {
	var images : MovieImageConfiguration?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		
		images <- map["images"]
	}

}
